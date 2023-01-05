import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import '../entities/add_number.dart';
import '../repositories/home_page_repository.dart';

class PostAddNumber extends UseCase<AddNumber?, PostAddNumberParams> {
  final HomePageRepository _homePageRepository;

  PostAddNumber(this._homePageRepository);
  @override
  Future<Stream<AddNumber?>> buildUseCaseStream(
      PostAddNumberParams? params) async {
    StreamController<AddNumber?> controller = StreamController();
    try {
      AddNumber? list = await _homePageRepository.postAddNumber(
          params!.sku,
          params.name,
          params.number,
          params.countryCode,
          params.token,
          params.detail,
          params.device);
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

class PostAddNumberParams {
  final String sku;
  final String name;
  final String number;
  final String countryCode;
  final String token;
  final String detail;
  final String device;

  PostAddNumberParams(this.sku, this.name, this.number, this.countryCode,
      this.token, this.detail, this.device);
}
