import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DevicesController extends Controller {
  int pageIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  final String deneme = 'Deneme';

  SharedPreferences? sharedPreferences;
  String? deviceImei;

  @override
  void onInitState() async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.getString('deviceImei') != null
        ? deviceImei = sharedPreferences!.getString('deviceImei')
        : null;
  }

  @override
  void initListeners() {
   
  }
  void pagejumpController(value) {
    pageIndex = value;
    refreshUI();
  }
}
