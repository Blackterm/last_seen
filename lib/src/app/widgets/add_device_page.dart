import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wpfamilylastseen/src/app/pages/devices/devices_controller.dart';

class AddDevicePage extends View {
  @override
  State<StatefulWidget> createState() {
    return _AddDevicePageState(DevicesController());
  }
}

class _AddDevicePageState extends ViewState<AddDevicePage, DevicesController> {
  _AddDevicePageState(DevicesController controller) : super(controller);

  bool hasSelectedItemBuilder = false;

  @override
  Widget get view {
    EdgeInsets padding = MediaQuery.of(context).padding;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: globalKey,
      body: ControlledWidgetBuilder<DevicesController>(
          builder: (context, controller) {
        return PageView(
          controller: controller.pageController,
          onPageChanged: controller.pagejumpController,
          physics: ScrollPhysics(parent: ScrollPhysics()),
          children: [
            Container(
              color: Colors.red,
              child: Center(
                child: Text(controller.deneme),
              ),
            ),
            Container(
              color: Colors.yellow,
              child: Center(
                child: Text('Deneme 2'),
              ),
            ),
            Container(
              color: Colors.green,
              child: Center(
                child: Text('Deneme 3'),
              ),
            ),
          ],
        );
      }),
    );
  }
}
