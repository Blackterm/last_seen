import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wpfamilylastseen/src/domain/entities/device_connections.dart';

import '../repositories/home_page_repository.dart';

class GetDeviceConnections
    extends UseCase<List<DeviceConnections>, GetDeviceConnectionsParams> {
  final HomePageRepository _homePageRepository;

  GetDeviceConnections(this._homePageRepository);
  @override
  Future<Stream<List<DeviceConnections>?>> buildUseCaseStream(
      GetDeviceConnectionsParams? params) async {
    StreamController<List<DeviceConnections>> controller = StreamController();
    try {
      List<DeviceConnections> list =
          await _homePageRepository.getDeviceConnections(
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

class GetDeviceConnectionsParams {
  final String device;

  GetDeviceConnectionsParams(this.device);
}
