import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';
import 'package:iconify_flutter/icons/icon_park_twotone.dart';
import 'package:wpfamilylastseen/src/app/pages/devices/devices_controller.dart';
import 'package:wpfamilylastseen/src/app/widgets/default_progress_indicator.dart';
import 'package:wpfamilylastseen/src/data/repositories/data_home_page_repository.dart';
import '../../constants/colors.dart';
import '../../widgets/analitics_custom_widgets.dart';
import '../../widgets/default_floating_button.dart';
import '../../widgets/home_wigets.dart';

class DevicesView extends View {
  @override
  State<StatefulWidget> createState() {
    return _DevicesViewState(DevicesController(DataHomePageRepository()));
  }
}

class _DevicesViewState extends ViewState<DevicesView, DevicesController> {
  _DevicesViewState(DevicesController controller) : super(controller);

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: globalKey,
      floatingActionButton: ControlledWidgetBuilder<DevicesController>(
          builder: (context, controller) {
        return DefaultFloatingButton(
            title: 'addDevice'.tr(),
            pressed: () {
              _editDevicePopUp(context, size, controller);
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
              child: ControlledWidgetBuilder<DevicesController>(
                  builder: (context, controller) {
                return controller.deviceConnectionsList != null
                    ? ListView.builder(
                        physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                        itemCount: controller.deviceConnectionsList!.length,
                        primary: false,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(16.0),
                        itemBuilder: (context, index) => _PhoneDetailContainer(
                              title: controller
                                  .deviceConnectionsList![index].name!,
                              status: controller
                                  .deviceConnectionsList![index].status!,
                              removeConnection: () {
                                controller.removeNumber(controller
                                    .deviceConnectionsList![index].id!
                                    .toString());
                              },
                            ))
                    : DefaultProgressIndicator();
              }),
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
  final Function() removeConnection;

  const _PhoneDetailContainer({
    required this.title,
    required this.status,
    required this.removeConnection,
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
              onPressed: removeConnection,
              icon: Iconify(
                Carbon.trash_can,
                color: Colorize.icon,
                size: 20,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Iconify(
                Fa6Solid.pen_to_square,
                color: Colorize.icon,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_editDevicePopUp(
  BuildContext context,
  Size size,
  DevicesController controller,
) =>
    popUpContainer(context, StatefulBuilder(
      builder: (context, setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            standartTitle('addDevice'.tr()),
            const SizedBox(height: 20.0),
            TextFieldy(
              hint: "Cihaz ismi",
              icon: const Iconify(IconParkTwotone.edit_name,
                  color: Colorize.icon),
              controller: controller.deviceNameController,
              type: null,
              suffix: null,
              enabled: true,
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CupertinoButton(
                borderRadius: BorderRadius.circular(8.0),
                color: Colorize.primary,
                onPressed: () {
                  controller.addDevice(controller.deviceNameController.text);
                  Navigator.pop(context);
                },
                child: Text(
                  "okay".tr(),
                  style: const TextStyle(color: Colorize.black, fontSize: 16.0),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "close".tr().toUpperCase(),
                style: const TextStyle(color: Colorize.textSec),
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        );
      },
    ));
standartTitle(String text) => Text(text,
    style: const TextStyle(
        fontSize: 22.0, fontWeight: FontWeight.w500, color: Colorize.text));
