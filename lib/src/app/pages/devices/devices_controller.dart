import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wpfamilylastseen/src/app/pages/devices/devices_presenter.dart';
import 'package:wpfamilylastseen/src/domain/entities/add_connection.dart';
import 'package:wpfamilylastseen/src/domain/entities/device_connections.dart';

import '../../../domain/repositories/home_page_repository.dart';
import '../../widgets/default_notification_banner.dart';

class DevicesController extends Controller {
  final DevicesPresenter _presenter;

  DevicesController(HomePageRepository homePageRepository)
      : _presenter = DevicesPresenter(homePageRepository);

  int pageIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  TextEditingController deviceNameController = TextEditingController();

  SharedPreferences? sharedPreferences;

  bool isListFetched = false;
  String? deviceImei;
  List<DeviceConnections>? deviceConnectionsList;
  AddConnection? addConnection;

  bool? toDoSetup;

  bool toDoCopy = false;

  @override
  void onInitState() async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.getString('deviceImei') != null
        ? deviceImei = sharedPreferences!.getString('deviceImei')
        : null;
    await sharedPreferences!.getBool('toDoSetup') != null
        ? toDoSetup = sharedPreferences!.getBool('toDoSetup')
        : null;

    _presenter.getDeviceConnections(deviceImei!);
  }

  @override
  void initListeners() {
    _presenter.deviceConnectionsOnNext = (List<DeviceConnections>? response) {
      if (response == null) return;
      if (!isListFetched) {
        deviceConnectionsList = response;
        refreshUI();
      }
    };

    _presenter.addConnectionOnNext = (AddConnection? response) {
      if (response == null) return;
      if (!isListFetched) {
        addConnection = response;
        refreshUI();
        _presenter.getDeviceConnections(deviceImei!);
      }
    };

    _presenter.removeConnectionOnNext = (dynamic response) async {
      if (response == null) return;
      if (response) {
        _presenter.getDeviceConnections(deviceImei!);
      } else {
        DefaultNotificationBanner(
                icon: Icon(Icons.error_outline),
                text: "somethingswentwrong".tr(),
                color: Colors.red,
                context: getContext())
            .show();
      }
    };
  }

  void addDevice(String deviceName) {
    _presenter.postAddConnection(deviceName, deviceImei!);
  }

  void removeNumber(String connectionId) {
    _presenter.removeConnection(connectionId, deviceImei!);

    refreshUI();
  }

  void copyController() {
    DefaultNotificationBanner(
      icon: Icon(Icons.check),
      text: "Başarılı bir şekilde kopyalandı",
      color: Colors.green,
      context: getContext(),
    ).show();
  }
}
