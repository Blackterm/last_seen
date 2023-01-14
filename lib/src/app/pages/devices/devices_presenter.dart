import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wpfamilylastseen/src/domain/entities/add_connection.dart';
import 'package:wpfamilylastseen/src/domain/entities/device_connections.dart';
import 'package:wpfamilylastseen/src/domain/usecases/get_device_connections.dart';
import 'package:wpfamilylastseen/src/domain/usecases/post_add_connection.dart';
import 'package:wpfamilylastseen/src/domain/usecases/remove_connection.dart';

import '../../../domain/repositories/home_page_repository.dart';

class DevicesPresenter extends Presenter {
  late Function deviceConnectionsOnNext;
  late Function deviceConnectionsOnError;

  late Function addConnectionOnNext;
  late Function addConnectionOnError;

  late Function removeConnectionOnNext;
  late Function removeConnectionOnError;

  final GetDeviceConnections _getDeviceConnections;
  final PostAddConnection _postAddConnection;
  final RemoveConnection _removeConnection;

  DevicesPresenter(HomePageRepository _homePageRepository)
      : _getDeviceConnections = GetDeviceConnections(_homePageRepository),
        _postAddConnection = PostAddConnection(_homePageRepository),
        _removeConnection = RemoveConnection(_homePageRepository);

  void getDeviceConnections(String device) {
    _getDeviceConnections.execute(
        _DeviceConnectionsObserver(this), GetDeviceConnectionsParams(device));
  }

  void postAddConnection(String deviceName, String device) {
    _postAddConnection.execute(_PostConnectionObserver(this),
        PostAddConnectionParams(deviceName, device));
  }

  void removeConnection(String connectionId, String device) {
    _removeConnection.execute(_RemoveConnectionObserver(this),
        RemoveConnectionParams(connectionId, device));
  }

  @override
  void dispose() {
    _getDeviceConnections.dispose();
    _postAddConnection.dispose();
    _removeConnection.dispose();
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

class _PostConnectionObserver extends Observer<AddConnection?> {
  final DevicesPresenter _presenter;
  _PostConnectionObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.addConnectionOnError(e);
  }

  @override
  void onNext(AddConnection? response) {
    _presenter.addConnectionOnNext(response);
  }
}

class _RemoveConnectionObserver extends Observer<dynamic> {
  final DevicesPresenter _presenter;

  _RemoveConnectionObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.removeConnectionOnError(e);
  }

  @override
  void onNext(dynamic response) {
    _presenter.removeConnectionOnNext(response);
  }
}
