import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:wpfamilylastseen/src/app/pages/settings/settings_controller.dart';
import 'package:wpfamilylastseen/src/data/repositories/data_home_page_repository.dart';
import '../../constants/colors.dart';

class SettingsView extends View {
  @override
  State<StatefulWidget> createState() {
    return _SplashViewState(SettingsController(
      DataHomePageRepository(),
    ));
  }
}

class _SplashViewState extends ViewState<SettingsView, SettingsController> {
  _SplashViewState(SettingsController controller) : super(controller);

  @override
  Widget get view {
    String deviceCountry = Platform.localeName.substring(3, 5);

    EdgeInsets padding = MediaQuery.of(context).padding;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("generalSettings".tr()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ControlledWidgetBuilder<SettingsController>(
              builder: (context, controller) {
            return Column(
              children: [
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: controller.list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ListTile(
                        tileColor: Colorize.layer,
                        horizontalTitleGap: 8.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        leading: Iconify(controller.list[index]['icon'],
                            color: Colorize.icon),
                        title: Text(controller.list[index]['title']),
                        onTap: controller.list[index]['onTap'],
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('email'.tr(),
                          style: TextStyle(color: Colorize.text)),
                      controller.lastSeenSettings != null
                          ? Text(
                              controller.lastSeenSettings!.mail != null
                                  ? controller.lastSeenSettings!.mail!
                                  : "-",
                              style: const TextStyle(color: Colorize.primary))
                          : Container(),
                    ],
                  ),
                ),
                Text(
                    controller.deviceImei != null ? controller.deviceImei! : "",
                    style: TextStyle(color: Colorize.icon)),
                const SizedBox(height: 24.0),
                Opacity(opacity: 0.5, child: Text(deviceCountry)),
                SizedBox(
                  height: padding.bottom + 10,
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
