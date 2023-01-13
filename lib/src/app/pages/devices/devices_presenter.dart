import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wpfamilylastseen/src/domain/entities/device_connections.dart';
import 'package:wpfamilylastseen/src/domain/usecases/get_device_connections.dart';

import '../../../domain/repositories/home_page_repository.dart';

class DevicesPresenter extends Presenter {
  late Function deviceConnectionsOnNext;
  late Function deviceConnectionsOnError;

  final GetDeviceConnections _getDeviceConnections;

  DevicesPresenter(HomePageRepository _homePageRepository)
      : _getDeviceConnections = (GetDeviceConnections(_homePageRepository));

  void getDeviceConnections(String device) {
    _getDeviceConnections.execute(
        _DeviceConnectionsObserver(this), GetDeviceConnectionsParams(device));
  }

  @override
  void dispose() {
    _getDeviceConnections.dispose();
  }
}

class _DeviceConnectionsObserver extends Observer<List<DeviceConnections>> {
  final DevicesPresenter _presenter;
  _DeviceConnectionsObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.deviceConnectionsOnError(e);
  }

  @override
  void onNext(List<DeviceConnections>? response) {
    _presenter.deviceConnectionsOnNext(response);
  }
}
