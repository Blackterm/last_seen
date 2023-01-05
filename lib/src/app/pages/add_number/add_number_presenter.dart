import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wpfamilylastseen/src/domain/entities/add_number.dart';
import 'package:wpfamilylastseen/src/domain/entities/last_seen_product.dart';
import 'package:wpfamilylastseen/src/domain/entities/purchase_control.dart';
import 'package:wpfamilylastseen/src/domain/usecases/get_last_seen_product.dart';
import 'package:wpfamilylastseen/src/domain/usecases/get_purchase_control.dart';
import 'package:wpfamilylastseen/src/domain/usecases/post_add_number.dart';

import '../../../domain/entities/last_seen_settings.dart';
import '../../../domain/repositories/home_page_repository.dart';
import '../../../domain/usecases/get_last_seen_settings.dart';

class AddNumberPresenter extends Presenter {
  late Function addNumbersOnNext;
  late Function addNumbersOnError;

  late Function getProductOnNext;
  late Function getProductOnError;

  late Function getPurchaseControlOnNext;
  late Function getPurchaseControlOnError;

  late Function settingsOnNext;
  late Function settingsOnError;

  final PostAddNumber _postAddNumber;
  final GetLastSeenProduct _getLastSeenProduct;
  final GetPurchaseControl _getPurchaseControl;
  final GetLastSeenSettings _getLastSeenSettings;

  AddNumberPresenter(HomePageRepository _homePageRepository)
      : _postAddNumber = PostAddNumber(_homePageRepository),
        _getLastSeenProduct = GetLastSeenProduct(_homePageRepository),
        _getPurchaseControl = GetPurchaseControl(_homePageRepository),
        _getLastSeenSettings = GetLastSeenSettings(_homePageRepository);

  void postAddNumber(String sku, String name, String number, String countryCode,
      String token, String detail, String device) {
    _postAddNumber.execute(
        _AddNumberObserver(this),
        PostAddNumberParams(
            sku, name, number, countryCode, token, detail, device));
  }

  void getProducts(String device) {
    _getLastSeenProduct.execute(
        _GetProductObserver(this), GetLastSeenProductParams(device));
  }

  void getGetPurchaseControl(String product_sku, String verify_token) {
    _getPurchaseControl.execute(_GetPurchaseControlObserver(this),
        GetPurchaseControlParams(product_sku, verify_token));
  }

  void getSettings(String device) {
    _getLastSeenSettings.execute(
        _SettingsObserver(this), GetLastSeenSettingsParams(device));
  }

  @override
  void dispose() {
    _postAddNumber.dispose();
    _getLastSeenProduct.dispose();
    _getPurchaseControl.dispose();
    _getLastSeenSettings.dispose();
  }
}

class _AddNumberObserver extends Observer<AddNumber?> {
  final AddNumberPresenter _presenter;
  _AddNumberObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.addNumbersOnError(e);
  }

  @override
  void onNext(AddNumber? response) {
    _presenter.addNumbersOnNext(response);
  }
}

class _GetProductObserver extends Observer<List<LastSeenProduct>> {
  final AddNumberPresenter _presenter;
  _GetProductObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.getProductOnError(e);
  }

  @override
  void onNext(List<LastSeenProduct>? response) {
    _presenter.getProductOnNext(response);
  }
}

class _GetPurchaseControlObserver extends Observer<PurchaseControl?> {
  final AddNumberPresenter _presenter;
  _GetPurchaseControlObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.getPurchaseControlOnError(e);
  }

  @override
  void onNext(PurchaseControl? response) {
    _presenter.getPurchaseControlOnNext(response);
  }
}

class _SettingsObserver extends Observer<LastSeenSettings?> {
  final AddNumberPresenter _presenter;

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
