import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import '../../../domain/entities/langauge_register.dart';
import '../../../domain/entities/last_seen_settings.dart';
import '../../../domain/repositories/home_page_repository.dart';
import '../../../domain/usecases/get_last_seen_settings.dart';
import '../../../domain/usecases/post_langauge_register.dart';

class SplashPresenter extends Presenter {
  late Function langaugeRegisterOnNext;
  late Function langaugeRegisterOnError;

  late Function settingsOnNext;
  late Function settingsOnError;

  final PostLangaugeRegister _postLangaugeRegister;
  final GetLastSeenSettings _getLastSeenSettings;

  SplashPresenter(HomePageRepository _homePageRepository)
      : _postLangaugeRegister = PostLangaugeRegister(_homePageRepository),
        _getLastSeenSettings = GetLastSeenSettings(_homePageRepository);

  void postLangaugeRegister(String device, String tokenData, String timezone,
      String locale, String version) {
    _postLangaugeRegister.execute(
        _LangaugeRegisterObserver(this),
        PostLangaugeRegisterParams(
            device, tokenData, timezone, locale, version));
  }

  void getSettings(String device) {
    _getLastSeenSettings.execute(
        _SettingsObserver(this), GetLastSeenSettingsParams(device));
  }

  @override
  void dispose() {
    _postLangaugeRegister.dispose();
    _getLastSeenSettings.dispose();
  }
}

class _LangaugeRegisterObserver extends Observer<LangaugeRegister?> {
  final SplashPresenter _presenter;

  _LangaugeRegisterObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.langaugeRegisterOnError(e);
  }

  @override
  void onNext(LangaugeRegister? response) {
    _presenter.langaugeRegisterOnNext(response);
  }
}

class _SettingsObserver extends Observer<LastSeenSettings?> {
  final SplashPresenter _presenter;

  _SettingsObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.settingsOnError(e);
  }

  @override
  void onNext(LastSeenSettings? response) {
    _presenter.settingsOnNext(response);
  }
}