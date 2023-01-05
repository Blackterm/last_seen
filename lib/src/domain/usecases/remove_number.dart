import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import '../repositories/home_page_repository.dart';

class RemoveNumber extends UseCase<dynamic, RemoveNumberParams> {
  final HomePageRepository _homePageRepository;

  RemoveNumber(this._homePageRepository);
  @override
  Future<Stream<dynamic>> buildUseCaseStream(RemoveNumberParams? params) async {
    StreamController<dynamic> controller = StreamController();
    try {
      dynamic list = await _homePageRepository.removeNumber(
        params!.id,
        params.device,
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

class RemoveNumberParams {
  final String id;
  final String device;

  RemoveNumberParams(this.id, this.device);
}
