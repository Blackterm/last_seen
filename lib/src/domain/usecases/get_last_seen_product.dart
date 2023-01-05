import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import '../entities/last_seen_product.dart';
import '../repositories/home_page_repository.dart';

class GetLastSeenProduct
    extends UseCase<List<LastSeenProduct>, GetLastSeenProductParams> {
  final HomePageRepository _homePageRepository;

  GetLastSeenProduct(this._homePageRepository);
  @override
  Future<Stream<List<LastSeenProduct>?>> buildUseCaseStream(
      GetLastSeenProductParams? params) async {
    StreamController<List<LastSeenProduct>> controller = StreamController();
    try {
      List<LastSeenProduct> list = await _homePageRepository.getLastSeenProduct(
        params!.device,
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

class GetLastSeenProductParams {
  final String device;

  GetLastSeenProductParams(this.device);
}
