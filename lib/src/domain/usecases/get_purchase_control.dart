import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wpfamilylastseen/src/domain/entities/purchase_control.dart';

import '../repositories/home_page_repository.dart';

class GetPurchaseControl
    extends UseCase<PurchaseControl?, GetPurchaseControlParams> {
  final HomePageRepository _homePageRepository;

  GetPurchaseControl(this._homePageRepository);
  @override
  Future<Stream<PurchaseControl?>> buildUseCaseStream(
      GetPurchaseControlParams? params) async {
    StreamController<PurchaseControl?> controller = StreamController();
    try {
      PurchaseControl? list = await _homePageRepository.getPurchaseControl(
        params!.product_sku,
        params.verify_token,
      );
      controller.add(list);
      controller.close();
    } catch (e, st) {
      print(e);
      print(st);
      controller.addError(e, st);
    }
    return controller.stream;
  }
}

class GetPurchaseControlParams {
  final String product_sku;
  final String verify_token;

  GetPurchaseControlParams(this.product_sku, this.verify_token);
}
