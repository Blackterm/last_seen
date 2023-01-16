import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/eva.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';
import 'package:iconify_flutter/icons/gg.dart';
import 'package:iconify_flutter/icons/ion.dart';
import 'package:iconify_flutter/icons/wpf.dart';
import 'package:wpfamilylastseen/src/app/pages/devices/devices_view.dart';
import 'package:wpfamilylastseen/src/app/pages/home/home_controller.dart';
import 'package:wpfamilylastseen/src/app/pages/settings/settings_view.dart';
import 'package:wpfamilylastseen/src/data/repositories/data_home_page_repository.dart';
import 'package:wpfamilylastseen/src/domain/entities/last_seen_numbers.dart';
import '../../constants/colors.dart';
import '../../widgets/default_floating_button.dart';
import '../../widgets/home_page_popups.dart';
import '../../widgets/home_wigets.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../widgets/tracking_dialog.dart';

class HomeView extends View {
  @override
  State<StatefulWidget> createState() {
    return _HomeViewState(HomeController(
      DataHomePageRepository(),
    ));
  }
}

class _HomeViewState extends ViewState<HomeView, HomeController> {
  _HomeViewState(HomeController controller) : super(controller);

  late int selectedTab = 0;

  @override
  Widget get view {
    EdgeInsets padding = MediaQuery.of(context).padding;
    return Scaffold(
      key: globalKey,
      floatingActionButton: ControlledWidgetBuilder<HomeController>(
          builder: (context, controller) {
        return controller.langaugeRegister != null
            ? DefaultFloatingButton(
                title: 'addNumber'.tr(),
                pressed: () {
                  controller.purchaseIsAvailbleControl();
                })
            : Container();
      }),
      body: ControlledWidgetBuilder<HomeController>(
          builder: (context, controller) {
        return SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: Column(
            children: [
              _appBar(context, () {
                controller.refreshView();
              }, controller),
              controller.lastSeenNumbers != null &&
                      controller.lastSeenNumbers != 0
                  ? HomePagePhoneList(
                      phones: controller.lastSeenNumbers,
                      controller: controller,
                    )
                  : NullPhoneWidget(),
              controller.lastSeenNumbersIsFavori.length != 0 &&
                      controller.lastSeenNumbersIsFavori.length >= 2
                  ? HomeActivitiesTabBar(
                      phones: controller.lastSeenNumbersIsFavori,
                      selectedTab: selectedTab,
                      changed: (v) {
                        setState(() => selectedTab = v!);
                      },
                    )
                  : _TabTitle(
                      lastSeenNumbers: controller.lastSeenNumbersIsFavori,
                    ),
              controller.lastSeenNumbersIsFavori.length != 0
                  ? HomeActivitiesListView(
                      tabIndex: selectedTab,
                      list: controller.langaugeRegister!,
                      phones: controller.lastSeenNumbersIsFavori,
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 32.0),
                      decoration: BoxDecoration(
                        color: Colorize.layer,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Column(
                        children: [
                          const Iconify(
                            Carbon.favorite,
                            size: 64.0,
                            color: Colorize.icon,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'yoursavedfavoritenumber'.tr(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colorize.textSec,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
              SizedBox(
                height: padding.bottom,
              )
            ],
          ),
        );
      }),
    );
  }

  AppBar _appBar(
    BuildContext context,
    Function() pressed,
    HomeController controller,
  ) {
    return AppBar(
      title: HomeAppBarTitle(),
      actions: [
        controller.lastSeenSettings != null &&
                controller.lastSeenSettings!.isShowModal != 0
            ? HomeActionTryDemoButton(
                title: 'switchPro'.tr(),
                controller: controller,
              )
            : Container(),
        HomePageIconButton(icon: Ion.refresh_circle, pressed: pressed),
        HomePageIconButton(
            icon: Eva.settings_fill,
            pressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsView()),
              );
            }),
        const SizedBox(width: 16.0),
      ],
    );
  }
}

class HomePageActivitiesWidget extends StatefulWidget {
  final Function(DateTime)? tapDate;
  final List<LastSeenNumbers>? phones;
  final DateTime? currentDate;
  const HomePageActivitiesWidget(
      {Key? key, this.phones, this.tapDate, this.currentDate})
      : super(key: key);

  @override
  State<HomePageActivitiesWidget> createState() =>
      _HomePageActivitiesWidgetState();
}

class _HomePageActivitiesWidgetState extends State<HomePageActivitiesWidget> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          HomeActivitiesTabBar(
              selectedTab: selectedTab,
              phones: widget.phones!,
              changed: (v) {
                setState(() => selectedTab = v!);
              }),
        ],
      ),
    );
  }
}

class HomePagePhoneList extends StatelessWidget {
  final List<LastSeenNumbers>? phones;
  final HomeController controller;
  const HomePagePhoneList({
    this.phones,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return phones!.length != 0
        ? Container(
            height: size.height * 0.5,
            child: ListView.builder(
              physics: ScrollPhysics(parent: BouncingScrollPhysics()),
              itemCount: phones!.length,
              primary: false,
              shrinkWrap: true,
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (context, index) => HomePagePhoneCardTile(
                phones: phones![index],
                controller: controller,
              ),
            ),
          )
        : NullPhoneWidget();
  }
}

class HomePagePhoneCardTile extends StatefulWidget {
  final LastSeenNumbers? phones;

  final HomeController controller;
  const HomePagePhoneCardTile({
    this.phones,
    required this.controller,
  });

  @override
  State<HomePagePhoneCardTile> createState() => _HomePagePhoneCardTileState();
}

class _HomePagePhoneCardTileState extends State<HomePagePhoneCardTile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return widget.phones != null
        ? Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colorize.layer,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 4.0),
                      margin: const EdgeInsets.only(left: 40.0),
                      decoration: BoxDecoration(
                        color: widget.phones!.status == 2
                            ? Colorize.red
                            : widget.phones!.status == 1
                                ? Colorize.primary
                                : Colorize.amber,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: widget.phones!.status == 0
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Iconify(
                                  Bx.time_five,
                                  size: 10.0,
                                  color: Colorize.text,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  "onHold".tr(),
                                  style: const TextStyle(
                                    fontSize: 10.0,
                                    color: Colorize.text,
                                  ),
                                ),
                              ],
                            )
                          : widget.phones!.status == 1
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Iconify(
                                      Gg.play_button,
                                      size: 10.0,
                                      color: Colorize.black,
                                    ),
                                    const SizedBox(width: 4.0),
                                    Text(
                                      "tracking".tr(),
                                      style: const TextStyle(
                                        fontSize: 10.0,
                                        color: Colorize.black,
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Iconify(
                                      Gg.danger,
                                      size: 10.0,
                                      color: Colorize.black,
                                    ),
                                    const SizedBox(width: 4.0),
                                    Text(
                                      "finised".tr(),
                                      style: const TextStyle(
                                        fontSize: 10.0,
                                        color: Colorize.black,
                                      ),
                                    ),
                                  ],
                                ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Visibility(
                      visible: widget.phones!.status == 2 ? false : true,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                          color: widget.phones!.is_online != true
                              ? Colorize.layer
                              : Colorize.primary,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: widget.phones!.is_online != true
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Iconify(
                                    Carbon.close,
                                    size: 10.0,
                                    color: Colorize.text,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    "offline".tr(),
                                    style: const TextStyle(
                                      fontSize: 10.0,
                                      color: Colorize.text,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Iconify(
                                    Carbon.user_online,
                                    size: 10.0,
                                    color: Colorize.black,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    "online".tr(),
                                    style: const TextStyle(
                                      fontSize: 10.0,
                                      color: Colorize.black,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Iconify(
                          Carbon.phone_voice_filled,
                          size: 32.0,
                          color: Colorize.icon,
                        ),
                        const SizedBox(width: 8.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.phones!.name!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '+${widget.phones!.countryCode}${widget.phones!.number}',
                              style: const TextStyle(color: Colorize.icon),
                            ),
                          ],
                        ),
                      ],
                    ),
                    widget.phones != null && widget.phones!.use_type != 0 ||
                            widget.phones!.connection_type != 0
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 24.0,
                                height: 24.0,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    widget.controller.nameController.text =
                                        widget.phones!.name!;

                                    editPhonePopUp(
                                      context,
                                      widget.phones!,
                                      widget.phones!.notification!,
                                      widget.controller,
                                      size,
                                      widget.phones!.isFavorite!,
                                    );
                                  },
                                  icon: const Iconify(
                                    Fa6Solid.pen_to_square,
                                    color: Colorize.icon,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              SizedBox(
                                width: 24.0,
                                height: 24.0,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    widget.controller.numberQuery(
                                        widget.phones!.id.toString());
                                  },
                                  icon: const Iconify(
                                    Wpf.statistics,
                                    color: Colorize.icon,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : InkWell(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colorize.red,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Text('Kurulum bekliyor'),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TrackingDialog(),
                                ),
                              );
                            },
                          )
                  ],
                )
              ],
            ),
          )
        : Container();
  }
}

class NullPhoneWidget extends StatelessWidget {
  const NullPhoneWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.5,
      child: Center(
        child: Opacity(
          opacity: 0.6,
          child: Text('youhavenotnumber'.tr()),
        ),
      ),
    );
  }
}

class _TabTitle extends StatelessWidget {
  final List<LastSeenNumbers>? lastSeenNumbers;

  _TabTitle({required this.lastSeenNumbers});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return lastSeenNumbers != null && lastSeenNumbers!.length != 0
        ? Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colorize.primary,
            ),
            child: Center(child: Text(lastSeenNumbers!.last.name!)),
          )
        : Container();
  }
}
