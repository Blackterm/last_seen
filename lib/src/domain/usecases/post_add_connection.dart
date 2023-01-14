import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wpfamilylastseen/src/domain/entities/add_connection.dart';
import '../repositories/home_page_repository.dart';

class PostAddConnection
    extends UseCase<AddConnection?, PostAddConnectionParams> {
  final HomePageRepository _homePageRepository;

  PostAddConnection(this._homePageRepository);
  @override
  Future<Stream<AddConnection?>> buildUseCaseStream(
      PostAddConnectionParams? params) async {
    StreamController<AddConnection?> controller = StreamController();
    try {
      AddConnection? list = await _homePageRepository.postAddConnection(
        params!.deviceName,
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

class PostAddConnectionParams {
  final String deviceName;
  final String device;

  PostAddConnectionParams(this.deviceName, this.device);
}
