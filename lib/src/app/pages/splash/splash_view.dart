import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wpfamilylastseen/src/app/pages/splash/splash_controller.dart';
import '../../../data/repositories/data_home_page_repository.dart';

class SplashView extends View {
  @override
  State<StatefulWidget> createState() {
    return _SplashViewState(SplashController(DataHomePageRepository()));
  }
}

class _SplashViewState extends ViewState<SplashView, SplashController> {
  _SplashViewState(SplashController controller) : super(controller);

  @override
  Widget get view {
    EdgeInsets padding = MediaQuery.of(context).padding;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: globalKey,
      body: Center(
        child: SizedBox(
          width: 64.0,
          child: Image.asset('assets/launcher_icon.png'),
        ),
      ),
    );
  }
}
