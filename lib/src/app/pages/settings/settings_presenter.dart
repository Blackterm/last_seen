import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wpfamilylastseen/src/domain/entities/last_seen_languages.dart';
import 'package:wpfamilylastseen/src/domain/entities/last_seen_settings.dart';
import 'package:wpfamilylastseen/src/domain/usecases/get_last_seen_languages.dart';
import 'package:wpfamilylastseen/src/domain/usecases/get_last_seen_settings.dart';
import '../../../domain/entities/langauge_register.dart';
import '../../../domain/repositories/home_page_repository.dart';
import '../../../domain/usecases/get_langauge_register.dart';

class SettingsPresenter extends Presenter {
  late Function langaugeRegisterOnNext;
  late Function langaugeRegisterOnError;

  late Function settingsOnNext;
  late Function settingsOnError;

  late Function langaugesOnNext;
  late Function langaugesOnError;

  final GetLangaugeRegister _getLangaugeRegister;
  final GetLastSeenSettings _getLastSeenSettings;
  final GetLastSeenLanguages _getLastSeenLanguages;

  SettingsPresenter(HomePageRepository _homePageRepository)
      : _getLangaugeRegister = GetLangaugeRegister(_homePageRepository),
        _getLastSeenSettings = GetLastSeenSettings(_homePageRepository),
        _getLastSeenLanguages = GetLastSeenLanguages(_homePageRepository);

  void getLangaugeRegister() {
    _getLangaugeRegister.execute(_LangaugeRegisterObserver(this));
  }

  void getSettings(String device) {
    _getLastSeenSettings.execute(
        _SettingsObserver(this), GetLastSeenSettingsParams(device));
  }

  void getLastSeenLanguages(String device) {
    _getLastSeenLanguages.execute(
        _LastSeenLanguagesObserver(this), GetLastSeenLanguagesParams(device));
  }

  @override
  void dispose() {
    _getLangaugeRegister.dispose();
    _getLastSeenSettings.dispose();
    _getLastSeenLanguages.dispose();
  }
}

class _LangaugeRegisterObserver extends Observer<LangaugeRegister?> {
  final SettingsPresenter _presenter;

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
  final SettingsPresenter _presenter;

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

class _LastSeenLanguagesObserver extends Observer<List<LastSeenLanguages>> {
  final SettingsPresenter _presenter;

  _LastSeenLanguagesObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.langaugesOnError(e);
  }

  @override
  void onNext(List<LastSeenLanguages>? response) {
    _presenter.langaugesOnNext(response);
  }
}
