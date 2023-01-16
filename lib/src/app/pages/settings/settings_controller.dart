import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/heroicons.dart';
import 'package:iconify_flutter/icons/la.dart';
import 'package:iconify_flutter/icons/lucide.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wpfamilylastseen/src/app/pages/settings/settings_presenter.dart';
import 'package:wpfamilylastseen/src/domain/entities/last_seen_languages.dart';
import 'package:wpfamilylastseen/src/domain/entities/last_seen_settings.dart';
import '../../../domain/entities/langauge_register.dart';
import '../../../domain/repositories/home_page_repository.dart';
import '../../widgets/langauge_change_page.dart';
import '../../widgets/privacy_and_policy.dart';
import '../devices/devices_view.dart';

class SettingsController extends Controller {
  final SettingsPresenter _presenter;

  SettingsController(HomePageRepository homePageRepository)
      : _presenter = SettingsPresenter(homePageRepository);

  LangaugeRegister? langaugeRegister;
  LastSeenSettings? lastSeenSettings;
  List<LastSeenLanguages>? lastSeenLanguages;

  bool isEDeclarationFetched = false;
  SharedPreferences? sharedPreferences;
  String? deviceImei;

  @override
  void onInitState() async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.getString('deviceImei') != null
        ? deviceImei = sharedPreferences!.getString('deviceImei')
        : null;
    _presenter.getLangaugeRegister();
    _presenter.getSettings(deviceImei!);
    _presenter.getLastSeenLanguages(deviceImei!);
  }

  @override
  void initListeners() {
    _presenter.langaugeRegisterOnNext = (LangaugeRegister? response) async {
      if (response == null) return;
      if (!isEDeclarationFetched) {
        langaugeRegister = response;
        refreshUI();
      }
    };

    _presenter.settingsOnNext = (LastSeenSettings? response) {
      if (response == null) return;
      if (!isEDeclarationFetched) {
        lastSeenSettings = response;
        refreshUI();
      }
    };

    _presenter.langaugesOnNext = (List<LastSeenLanguages>? response) {
      if (response == null) return;
      if (!isEDeclarationFetched) {
        lastSeenLanguages = response;
        refreshUI();
      }
    };

    _presenter.langaugeRegisterOnError = (e) {
      log(e);
    };
  }

  late List<Map> list = [
    {
      "icon": Bx.devices,
      "title": "devices".tr(),
      "onTap": () {
        Navigator.push(
          getContext(),
          MaterialPageRoute(builder: (context) => DevicesView(false)),
        );
      },
    },
    {
      "icon": Bx.support,
      "title": "support".tr(),
      "onTap": () async {
        final Uri url = Uri(
          scheme: 'mailto',
          path: lastSeenSettings!.mail,
          query: encodeQueryParameters(<String, String>{
            'subject': "emailSupportSubject".tr(),
            'body': "emailSupportBody".tr(),
          }),
        );

        if (!await launchUrl(url, mode: LaunchMode.platformDefault)) {
          throw 'Could not launch $url';
        }
      },
    },
    {
      "icon": Lucide.file_terminal,
      "title": "termsofuse".tr(),
      "onTap": () {
        Navigator.push(
          getContext(),
          MaterialPageRoute(
              builder: (context) => PolicyAndPrivacyPage(
                  page: 'policy', content: lastSeenSettings!.termsOfUse!)),
        );
      },
    },
    {
      "icon": MaterialSymbols.privacy_tip_outline_rounded,
      "title": "privacypolicy".tr(),
      "onTap": () {
        Navigator.push(
          getContext(),
          MaterialPageRoute(
              builder: (context) => PolicyAndPrivacyPage(
                  page: 'privacy', content: lastSeenSettings!.privacyPolicy!)),
        );
      },
    },
    {
      "icon": La.google_play,
      "title": "rateus".tr(),
      "onTap": () async {
        final Uri url = Uri.parse(lastSeenSettings!.marketUrl!);

        if (!await launchUrl(url)) {
          throw 'Could not launch $url';
        }
      },
    },
    {
      "icon": Heroicons.language_solid,
      "title": "changeLang".tr(),
      "onTap": () {
        Navigator.push(
          getContext(),
          MaterialPageRoute(
            builder: (context) => LanguageChangePage(
              title: "changeLang".tr(),
              lastSeenLanguages: lastSeenLanguages!,
            ),
          ),
        );
      },
    }
  ];

  String encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
