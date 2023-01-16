import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wpfamilylastseen/src/app/pages/splash/splash_presenter.dart';
import 'package:wpfamilylastseen/src/app/widgets/default_notification_banner.dart';
import 'package:wpfamilylastseen/src/domain/entities/langauge_register.dart';
import '../../../data/helpers/notification_service.dart';
import '../../../domain/entities/last_seen_settings.dart';
import '../../../domain/repositories/home_page_repository.dart';
import '../../widgets/default_dialog.dart';
import '../home/home_view.dart';
import 'package:yaml/yaml.dart';

class SplashController extends Controller {
  final SplashPresenter _presenter;

  SplashController(HomePageRepository homePageRepository)
      : _presenter = SplashPresenter(homePageRepository);

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  SharedPreferences? sharedPreferences;

  LangaugeRegister? langaugeRegister;
  LastSeenSettings? lastSeenSettings;
  bool isEDeclarationFetched = false;
  PackageInfo? packageInfo;

  var result;

  @override
  void onInitState() async {
    packageInfo = await PackageInfo.fromPlatform();

    sharedPreferences = await SharedPreferences.getInstance();

    NotifService.connectNotification();

    result = await getDevice();
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();

    if (result != null) {
      _presenter.postLangaugeRegister(
        result['imei'],
        await NotifService.getToken(),
        currentTimeZone,
        Platform.localeName,
        result["modal"],
      );
      return;
    }
  }

  @override
  void initListeners() {
    _presenter.langaugeRegisterOnNext = (LangaugeRegister? response) async {
      if (response == null) return;
      if (!isEDeclarationFetched) {
        langaugeRegister = response;
        refreshUI();
        _presenter.getSettings(result['imei']);
      }
    };

    _presenter.settingsOnNext = (LastSeenSettings? response) {
      if (response == null) return;
      if (!isEDeclarationFetched) {
        lastSeenSettings = response;
        refreshUI();

        if (langaugeRegister != null &&
            langaugeRegister!.translations != null &&
            lastSeenSettings != null) {
          if (lastSeenSettings!.app_version != packageInfo!.version) {
            DefaultLoadingDialog(
              text: "updatetext".tr(),
              context: getContext(),
            ).show();
          } else {
            Navigator.pushAndRemoveUntil(
                (getContext()),
                CupertinoPageRoute(builder: (context) => HomeView()),
                (route) => false);
          }
        } else {
          DefaultNotificationBanner(
                  icon: Icon(Icons.error_outline),
                  text: "Server Error.",
                  color: Colors.red,
                  context: getContext())
              .show();
        }
      }
    };

    _presenter.langaugeRegisterOnError = (e) {
      log(e);
    };
  }

  Future getDevice() async {
    String? deviceId = await PlatformDeviceId.getDeviceId;

    Map<String?, String?>? device;
    try {
      if (Platform.isAndroid) {
        var info = await deviceInfoPlugin.androidInfo;

        device = {
          "imei": deviceId,
          "modal": info.model,
        };
      } else if (Platform.isIOS) {
        var info = await deviceInfoPlugin.iosInfo;
        device = {
          "imei": deviceId,
          "modal": info.utsname.machine,
        };
      }

      sharedPreferences!.setString("deviceImei", deviceId!);

      return device;
    } on PlatformException {
      log('device info error');
    }
  }
}
