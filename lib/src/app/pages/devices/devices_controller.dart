import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wpfamilylastseen/src/app/pages/devices/devices_presenter.dart';
import 'package:wpfamilylastseen/src/domain/entities/device_connections.dart';

import '../../../domain/repositories/home_page_repository.dart';

class DevicesController extends Controller {
  final DevicesPresenter _presenter;

  DevicesController(HomePageRepository homePageRepository)
      : _presenter = DevicesPresenter(homePageRepository);

  int pageIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  final String deneme = 'Deneme';

  SharedPreferences? sharedPreferences;

  bool isListFetched = false;
  String? deviceImei;
  List<DeviceConnections>? deviceConnectionsList;

  @override
  void onInitState() async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.getString('deviceImei') != null
        ? deviceImei = sharedPreferences!.getString('deviceImei')
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
  }

  void pagejumpController(value) {
    pageIndex = value;
    refreshUI();
  }
}
