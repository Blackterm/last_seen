import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';
import 'package:wpfamilylastseen/src/app/pages/devices/devices_controller.dart';
import 'package:wpfamilylastseen/src/app/widgets/add_device_page.dart';

import '../../constants/colors.dart';
import '../../widgets/default_floating_button.dart';

class DevicesView extends View {
  @override
  State<StatefulWidget> createState() {
    return _DevicesViewState(DevicesController());
  }
}

class _DevicesViewState extends ViewState<DevicesView, DevicesController> {
  _DevicesViewState(DevicesController controller) : super(controller);

  @override
  Widget get view {
    return Scaffold(
      key: globalKey,
      floatingActionButton: ControlledWidgetBuilder<DevicesController>(
          builder: (context, controller) {
        return DefaultFloatingButton(
            title: 'addDevice'.tr(),
            pressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddDevicePage()),
              );
            });
      }),
      appBar: AppBar(
        centerTitle: true,
        title: Text("devices".tr()),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: Column(
                children: [
                  _PhoneDetailContainer(title: "0555", status: 1),
                  _PhoneDetailContainer(title: "0555", status: 0),
                  _PhoneDetailContainer(title: "0555", status: 1),
                  _PhoneDetailContainer(title: "0555", status: 0),
                  _PhoneDetailContainer(title: "0555", status: 0),
                  _PhoneDetailContainer(title: "0555", status: 1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhoneDetailContainer extends StatelessWidget {
  final String title;
  final int status;

  const _PhoneDetailContainer({
    required this.title,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colorize.layer,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.phone_android,
                  color: Colorize.icon,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: TextStyle(color: Colorize.text),
                )
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
              decoration: BoxDecoration(
                color: status != 0 ? Colorize.primary : Colorize.layer,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Iconify(
                    status != 0 ? Carbon.checkmark : Carbon.close,
                    size: 10.0,
                    color: Colorize.black,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    status != 0 ? "active".tr() : "notActive".tr(),
                    style: const TextStyle(
                      fontSize: 10.0,
                      color: Colorize.black,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Iconify(
                Fa6Solid.pen_to_square,
                color: Colorize.icon,
                size: 23,
              ),
            )
          ],
        ),
      ),
    );
  }
}
