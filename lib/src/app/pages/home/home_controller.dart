import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:eventify/eventify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wpfamilylastseen/src/app/pages/home/home_presenter.dart';
import 'package:wpfamilylastseen/src/domain/entities/edit_number.dart';
import 'package:wpfamilylastseen/src/domain/entities/last_seen_numbers.dart'
    as nums;
import '../../../data/helpers/notification_service.dart';
import '../../../domain/entities/emitter_data.dart';
import '../../../domain/entities/langauge_register.dart';
import '../../../domain/entities/last_seen_number.dart';
import '../../../domain/entities/last_seen_settings.dart';
import '../../../domain/repositories/home_page_repository.dart';
import '../../widgets/analitics_pages.dart';
import '../../widgets/default_notification_banner.dart';
import '../../widgets/home_wigets.dart';
import '../../widgets/tracking_dialog.dart';
import '../add_number/add_number_view.dart';
import 'home_view.dart';

class HomeController extends Controller {
  final HomePresenter _presenter;

  HomeController(HomePageRepository homePageRepository)
      : _presenter = HomePresenter(homePageRepository);

  LangaugeRegister? langaugeRegister;
  List<nums.LastSeenNumbers>? lastSeenNumbers;
  List<nums.LastSeenNumbers> lastSeenNumbersIsFavori = [];
  List<nums.Events>? eventsList;

  LastSeenNumber? lastSeenNumber;
  bool isEDeclarationFetched = false;
  bool isPremium = false;
  bool isDeleted = true;

  var emitterListener;

  SharedPreferences? sharedPreferences;
  String? deviceImei;
  TextEditingController nameController = TextEditingController();
  InAppPurchase? inAppPurchase;
  EventEmitter? emitter;
  bool? useDemo;

  EmitterNumberStatus? emitterNumberStatus;
  EmitterAddEvent? emitterAddEvent;
  EmitterIsOnline? emitterIsOnline;
  LastSeenSettings? lastSeenSettings;

  @override
  void onInitState() async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.getString('deviceImei') != null
        ? deviceImei = sharedPreferences!.getString('deviceImei')
        : null;

    await sharedPreferences!.getBool('useDemo') != null
        ? useDemo = sharedPreferences!.getBool('useDemo')
        : null;
    inAppPurchase = InAppPurchase.instance;

    emitter = NotifService.getEmitter();

    emitterListener =
        emitter!.on('change_number_status', this, (ev, context) async {
      emitterNumberStatus = await EmitterNumberStatus.fromJson(
          jsonDecode(ev.eventData! as String));

      var index =
          lastSeenNumbers!.indexWhere((v) => v.id == emitterNumberStatus!.id);
      if (index != -1) {
        lastSeenNumbers![index].status = emitterNumberStatus!.status!;
        refreshUI();
        return;
      }
    });

    emitterListener = emitter!.on('is_online', this, (ev, context) async {
      emitterIsOnline =
          await EmitterIsOnline.fromJson(jsonDecode(ev.eventData! as String));

      var index =
          lastSeenNumbers!.indexWhere((v) => v.id == emitterIsOnline!.id);
      if (index != -1) {
        lastSeenNumbers![index].is_online =
            emitterIsOnline!.is_online! != 0 ? true : false;
        refreshUI();
        return;
      }
    });
    emitterListener = emitter!.on('add_event', this, (ev, context) async {
      emitterAddEvent =
          await EmitterAddEvent.fromJson(jsonDecode(ev.eventData! as String));

      var index =
          lastSeenNumbers!.indexWhere((v) => v.id == emitterAddEvent!.id);
      if (index != -1) {
        eventsList!.add(
          nums.Events(
            onlineHour: emitterAddEvent!.start_time,
            onlineDate: emitterAddEvent!.start_date,
            offlineHour: emitterAddEvent!.end_time,
            offlineDate: emitterAddEvent!.end_date,
          ),
        );
        eventsList!.addAll(lastSeenNumbers![index].events!);
        lastSeenNumbers![index].events = eventsList;
        refreshUI();
        return;
      }
    });

    _presenter.getLangaugeRegister();
    _presenter.getNumbers(deviceImei!);
    _presenter.getSettings(deviceImei!);
  }

  @override
  void dispose() {
    emitter!.off(emitterListener!);
    super.dispose();
  }

  @override
  void initListeners() {
    _presenter.langaugeRegisterOnNext = (LangaugeRegister? response) async {
      if (response == null) return;
      if (!isEDeclarationFetched) {
        langaugeRegister = response;
        refreshUI();

        langaugeRegister != null
            ? langaugeRegisterWait(langaugeRegister!)
            : null;
      }
    };

    _presenter.settingsOnNext = (LastSeenSettings? response) {
      if (response == null) return;
      if (!isEDeclarationFetched) {
        lastSeenSettings = response;
        refreshUI();

        !useDemo!
            ? lastSeenSettings != null
                ? settingsWait(lastSeenSettings!)
                : null
            : null;
      }
    };

    _presenter.numbersOnNext = (List<nums.LastSeenNumbers>? response) async {
      if (response == null) return;
      if (!isEDeclarationFetched) {
        lastSeenNumbers = response;
        refreshUI();
        lastSeenNumbers!.forEach((element) {
          element.isFavorite! ? lastSeenNumbersIsFavori.add(element) : null;
        });
      }
    };

    _presenter.numberOnNext = (LastSeenNumber? response) async {
      if (response == null) return;
      if (!isEDeclarationFetched) {
        lastSeenNumber = response;
        refreshUI();

        Navigator.push(
          getContext(),
          MaterialPageRoute(
              builder: (context) => AnaliticsPage(
                    lastSeenNumber: lastSeenNumber,
                    controller: this,
                  )),
        );
      }
    };

    _presenter.removeNumberOnNext = (dynamic response) async {
      if (response == null) return;
      if (response) {
        Navigator.pushAndRemoveUntil(
            (getContext()),
            CupertinoPageRoute(builder: (context) => HomeView()),
            (route) => false);
        isDeleted = true;
      } else {
        DefaultNotificationBanner(
                icon: Icon(Icons.error_outline),
                text: "somethingswentwrong".tr(),
                color: Colors.red,
                context: getContext())
            .show();
      }
    };

    _presenter.editNumberOnNext = (EditNumber? response) async {
      if (response == null) return;
      if (!isEDeclarationFetched) {
        Navigator.pushAndRemoveUntil(
            (getContext()),
            CupertinoPageRoute(builder: (context) => HomeView()),
            (route) => false);

        refreshUI();
      }
    };

    _presenter.postEditConnectionOnNext = (dynamic response) async {
      if (response == null) return;
      if (response) {
        Navigator.pushAndRemoveUntil(
            (getContext()),
            CupertinoPageRoute(builder: (context) => HomeView()),
            (route) => false);
      } else {
        DefaultNotificationBanner(
                icon: Icon(Icons.error_outline),
                text: "somethingswentwrong".tr(),
                color: Colors.red,
                context: getContext())
            .show();
      }
    };

    _presenter.numbersOnError = (e) {
      log(e);
    };

    _presenter.langaugeRegisterOnError = (e) {
      log(e);
    };

    _presenter.settingsOnError = (e) {
      log(e);
    };
  }

  void langaugeRegisterWait(LangaugeRegister langaugeRegister) {
    Future.delayed(Duration.zero).then(
      (_) => useDemo == null
          ? langaugeRegister.useDemo != null
              ? sharedPreferences!.setBool('useDemo', langaugeRegister.useDemo!)
              : null
          : langaugeRegister.useDemo = useDemo,
    );
  }

  void settingsWait(LastSeenSettings lastSeenSettings) {
    Timer(
      Duration(
          seconds: lastSeenSettings.ctaPeriod != null
              ? lastSeenSettings.ctaPeriod!
              : 6),
      () => Navigator.push(
        getContext(),
        MaterialPageRoute(
          builder: (context) => TrialFreePremium(
            controller: this,
          ),
        ),
      ),
    );
  }

  void removeNumber(String id) {
    _presenter.removeNumber(id, deviceImei!);
    isDeleted = false;
    refreshUI();
  }

  void refreshView() {
    _presenter.getLangaugeRegister();
    _presenter.getNumbers(deviceImei!);
    _presenter.getSettings(deviceImei!);
  }

  void numberQuery(String numberId) {
    _presenter.getNumber(numberId, deviceImei!);
  }

  Map<int, Text> activeNum(TextStyle style) {
    var numbers =
        lastSeenNumber!.graphics!.map((e) => Text(e.hour!, style: style));

    var numbersWidget = Map<int, Text>();

    var index = 0;
    numbers.forEach((element) {
      numbersWidget[index] = element;
      index++;
    });

    return numbersWidget;
  }

  void editNumber(
    String name,
    String notif,
    String phoneId,
    String isFavorite,
  ) {
    _presenter.postEditNumber(name, notif, phoneId, isFavorite, deviceImei!);
  }

  void purchaseIsAvailbleControl() async {
    final bool isAvailable = await inAppPurchase!.isAvailable();

    if (!isAvailable) {
      DefaultNotificationBanner(
              icon: Icon(Icons.error_outline),
              text: "somethingswentwrong".tr(),
              color: Colors.red,
              context: getContext())
          .show();
      return;
    }
    await Navigator.push(
      getContext(),
      MaterialPageRoute(
        builder: (context) => AddNumberView(),
      ),
    );
  }

  void editConnectionControl(
    String connectionId,
    String numberId,
  ) {
    _presenter.postEditConnection(connectionId, numberId, deviceImei!);
  }
}
