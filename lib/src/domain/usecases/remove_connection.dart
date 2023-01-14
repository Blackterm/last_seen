import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../repositories/home_page_repository.dart';

class RemoveConnection extends UseCase<dynamic, RemoveConnectionParams> {
  final HomePageRepository _homePageRepository;

  RemoveConnection(this._homePageRepository);
  @override
  Future<Stream<dynamic>> buildUseCaseStream(
      RemoveConnectionParams? params) async {
    StreamController<dynamic> controller = StreamController();
    try {
      dynamic list = await _homePageRepository.removeConnection(
        params!.connectionId,
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

class RemoveConnectionParams {
  final String connectionId;
  final String device;

  RemoveConnectionParams(this.connectionId, this.device);
}
