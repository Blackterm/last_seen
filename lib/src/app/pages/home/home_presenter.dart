import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wpfamilylastseen/src/domain/entities/edit_number.dart';
import 'package:wpfamilylastseen/src/domain/entities/last_seen_numbers.dart';
import 'package:wpfamilylastseen/src/domain/usecases/get_langauge_register.dart';
import 'package:wpfamilylastseen/src/domain/usecases/get_last_seen_number.dart';
import 'package:wpfamilylastseen/src/domain/usecases/get_last_seen_numbers.dart';
import 'package:wpfamilylastseen/src/domain/usecases/post_edit_number.dart';
import 'package:wpfamilylastseen/src/domain/usecases/remove_number.dart';
import '../../../domain/entities/langauge_register.dart';
import '../../../domain/entities/last_seen_number.dart';
import '../../../domain/entities/last_seen_settings.dart';
import '../../../domain/repositories/home_page_repository.dart';
import '../../../domain/usecases/get_last_seen_settings.dart';

class HomePresenter extends Presenter {
  late Function langaugeRegisterOnNext;
  late Function langaugeRegisterOnError;

  late Function numbersOnNext;
  late Function numbersOnError;

  late Function editNumberOnNext;
  late Function editNumberOnError;

  late Function removeNumberOnNext;
  late Function removeNumberOnError;

  late Function numberOnNext;
  late Function numberOnError;

  late Function settingsOnNext;
  late Function settingsOnError;

  final GetLangaugeRegister _getLangaugeRegister;
  final GetLastSeenNumbers _getLastSeenNumbers;
  final RemoveNumber _removeNumber;
  final PostEditNumber _postEditNumber;
  final GetLastSeenNumber _getLastSeenNumber;
  final GetLastSeenSettings _getLastSeenSettings;

  HomePresenter(HomePageRepository _homePageRepository)
      : _getLangaugeRegister = GetLangaugeRegister(_homePageRepository),
        _getLastSeenNumbers = GetLastSeenNumbers(_homePageRepository),
        _removeNumber = RemoveNumber(_homePageRepository),
        _postEditNumber = PostEditNumber(_homePageRepository),
        _getLastSeenNumber = GetLastSeenNumber(_homePageRepository),
        _getLastSeenSettings = GetLastSeenSettings(_homePageRepository);

  void getLangaugeRegister() {
    _getLangaugeRegister.execute(_LangaugeRegisterObserver(this));
  }

  void getNumbers(String device) {
    _getLastSeenNumbers.execute(
        _NumbersObserver(this), GetLastSeenNumbersParams(device));
  }

  void removeNumber(String id, String device) {
    _removeNumber.execute(
        _RemoveNumberObserver(this), RemoveNumberParams(id, device));
  }

  void postEditNumber(String name, String notif, String phoneId,
      String isFavorite, String device) {
    _postEditNumber.execute(_EditNumberObserver(this),
        PostEditNumberParams(name, notif, phoneId, isFavorite, device));
  }

  void getNumber(String numberId, String device) {
    _getLastSeenNumber.execute(
        _NumberObserver(this), GetLastSeenNumberParams(numberId, device));
  }

  void getSettings(String device) {
    _getLastSeenSettings.execute(
        _SettingsObserver(this), GetLastSeenSettingsParams(device));
  }

  @override
  void dispose() {
    _getLangaugeRegister.dispose();
    _getLastSeenNumbers.dispose();
    _removeNumber.dispose();
    _postEditNumber.dispose();
    _getLastSeenNumber.dispose();
    _getLastSeenSettings.dispose();
  }
}

class _LangaugeRegisterObserver extends Observer<LangaugeRegister?> {
  final HomePresenter _presenter;

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

class _NumbersObserver extends Observer<List<LastSeenNumbers>> {
  final HomePresenter _presenter;

  _NumbersObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.numbersOnError(e);
  }

  @override
  void onNext(List<LastSeenNumbers>? response) {
    _presenter.numbersOnNext(response);
  }
}

class _RemoveNumberObserver extends Observer<dynamic> {
  final HomePresenter _presenter;

  _RemoveNumberObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.removeNumberOnError(e);
  }

  @override
  void onNext(dynamic response) {
    _presenter.removeNumberOnNext(response);
  }
}

class _EditNumberObserver extends Observer<EditNumber?> {
  final HomePresenter _presenter;

  _EditNumberObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.editNumberOnError(e);
  }

  @override
  void onNext(EditNumber? response) {
    _presenter.editNumberOnNext(response);
  }
}

class _NumberObserver extends Observer<LastSeenNumber?> {
  final HomePresenter _presenter;

  _NumberObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.numberOnError(e);
  }

  @override
  void onNext(LastSeenNumber? response) {
    _presenter.numberOnNext(response);
  }
}

class _SettingsObserver extends Observer<LastSeenSettings?> {
  final HomePresenter _presenter;

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
