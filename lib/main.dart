import 'package:country_codes/country_codes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eventify/eventify.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grock/grock.dart';
import 'package:wpfamilylastseen/src/app/constants/colors.dart';
import 'package:wpfamilylastseen/src/app/pages/splash/splash_view.dart';
import 'package:wpfamilylastseen/src/data/helpers/notification_service.dart';
import 'package:wpfamilylastseen/src/data/helpers/smart_network_asset.loader.dart';
import 'package:wpfamilylastseen/src/data/repositories/data_home_page_repository.dart';

void main() async {
  EventEmitter emitter = new EventEmitter();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  const SystemUiOverlayStyle(
      statusBarColor: Colorize.alpha, systemNavigationBarColor: Colorize.black);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  NotifService.setEmitter(emitter);
  await NotifService.initialize();
  await CountryCodes.init();

  List<Locale> _localeList = [];

  await DataHomePageRepository()
      .getLastSeenLanguages("")
      .then((value) => value.forEach((element) {
            _localeList.add(Locale(element.code!));
          }));

  runApp(EasyLocalization(
    path: 'http://www.osilates.net/api/v1/locales',
    fallbackLocale: Locale('en', 'US'),
    assetLoader: SmartNetworkAssetLoader(
        assetsPath: 'asserts/languages',
        localeUrl: (String localeName) =>
            'http://www.osilates.net/api/v1/locales/'),
    supportedLocales: _localeList,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Grock.navigationKey, // added line
      scaffoldMessengerKey: Grock.scaffoldMessengerKey,
      title: 'Wp Family Last Seen',
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      darkTheme: ThemeData.dark().copyWith(
        backgroundColor: Colorize.black,
        scaffoldBackgroundColor: Colorize.black,
        dividerTheme: const DividerThemeData(color: Colorize.layer),
        appBarTheme:
            const AppBarTheme(backgroundColor: Colorize.black, elevation: 0.0),
      ),
      home: SplashView(),
    );
  }
}
