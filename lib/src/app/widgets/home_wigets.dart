import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/akar_icons.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';
import 'package:iconify_flutter/icons/gg.dart';
import 'package:iconify_flutter/icons/wpf.dart';
import 'package:wpfamilylastseen/src/app/pages/add_number/add_number_view.dart';
import 'package:wpfamilylastseen/src/app/pages/home/home_controller.dart';
import 'package:wpfamilylastseen/src/domain/entities/langauge_register.dart';
import 'package:wpfamilylastseen/src/domain/entities/last_seen_numbers.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constants/colors.dart';
import 'home_page_popups.dart';

class HomeAppBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildAppLogo(),
        _buildAppTitle(),
      ],
    );
  }

  Widget _premium(lang) => Center(
      child: Text(lang.premium.toUpperCase(),
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w100,
              color: Colorize.icon)));

  Padding _buildAppTitle() => const Padding(
      padding: EdgeInsets.only(left: 8.0),
      child: Text('WFLS',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
              color: Colorize.icon)));
  SizedBox _buildAppLogo() => SizedBox(
      width: 32.0,
      height: 32.0,
      child: Image.asset('assets/launcher_icon_line.png'));
}

class HomeActionTryDemoButton extends StatefulWidget {
  final String title;
  final HomeController controller;

  const HomeActionTryDemoButton({
    super.key,
    required this.title,
    required this.controller,
  });

  @override
  State<HomeActionTryDemoButton> createState() =>
      _HomeActionTryDemoButtonState();
}

class _HomeActionTryDemoButtonState extends State<HomeActionTryDemoButton> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TrialFreePremium(
                controller: widget.controller,
              ),
            ),
          );
        },
        child: Text(widget.title,
            style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: Colorize.primary)));
  }
}

class HomePageIconButton extends StatelessWidget {
  final String icon;
  final Function()? pressed;

  const HomePageIconButton({
    required this.icon,
    required this.pressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32.0,
      height: 32.0,
      margin: const EdgeInsets.only(left: 4.0),
      child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: pressed,
          icon: Iconify(icon, color: Colorize.icon)),
    );
  }
}

Widget _staticsIcon(context) => SizedBox(
      width: 24.0,
      height: 24.0,
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {},
        icon: const Iconify(
          Wpf.statistics,
          color: Colorize.icon,
        ),
      ),
    );

Widget _editPhone(context, phone) => SizedBox(
      width: 24.0,
      height: 24.0,
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () => {},
        icon: const Iconify(
          Fa6Solid.pen_to_square,
          color: Colorize.icon,
        ),
      ),
    );

Widget _phoneNumber(phone) => Row(
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
              phone.name,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            Text(
              '+${phone.country}${phone.number}',
              style: const TextStyle(color: Colorize.icon),
            ),
          ],
        ),
      ],
    );

Widget _phoneStatusProgress(lang) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Iconify(
          Bx.time_five,
          size: 10.0,
          color: Colorize.text,
        ),
        const SizedBox(width: 4.0),
        Text(
          lang.procesing,
          style: const TextStyle(
            fontSize: 10.0,
            color: Colorize.text,
          ),
        ),
      ],
    );

Widget _phoneStatusOnHold(lang) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Iconify(
          Gg.danger,
          size: 10.0,
          color: Colorize.black,
        ),
        const SizedBox(width: 4.0),
        Text(
          lang.onHold,
          style: const TextStyle(
            fontSize: 10.0,
            color: Colorize.black,
          ),
        ),
      ],
    );

class TextFieldy extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final TextInputType? type;
  final Widget? suffix, icon;
  final bool? enabled;

  const TextFieldy(
      {required this.hint,
      this.icon,
      required this.controller,
      this.suffix,
      required this.type,
      this.enabled});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 1,
      enabled: enabled ?? true,
      keyboardType: type,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colorize.layer,
        hintText: hint,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0),
        ),
        hintStyle: const TextStyle(color: Colorize.icon),
        prefixIcon: icon != null
            ? SizedBox(
                width: 24.0,
                height: 24.0,
                child: Center(
                  child: icon,
                ),
              )
            : null,
        suffixIcon: suffix,
      ),
    );
  }
}

class HomeActivitiesTabBar extends StatelessWidget {
  final List<LastSeenNumbers> phones;
  final Function(int? value)? changed;
  final int? selectedTab;
  const HomeActivitiesTabBar(
      {Key? key, required this.phones, this.changed, this.selectedTab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: CupertinoSlidingSegmentedControl(
        backgroundColor: Colorize.layer,
        padding: const EdgeInsets.all(4.0),
        groupValue: selectedTab,
        onValueChanged: changed!,
        thumbColor: Colorize.primary,

        // TODO  TELEFONLARIN AKTİVİTELERİ BİRLEŞTİRİLİP TÜMÜ SEKMESİ OLARAK SIFIRINCI DİZİNE EKLENECEK
        // ! DİKKAT ! EN AZ 1 CİHAZ EKLENECEK DE OLSA TÜMÜ SEKMESİ OLMAK ZORUNDADIR
        // ! KURAL GEREĞİ SEKME SAYISI 1 OLAMAZ EN AZ İKİ OLMALIDIR
        // ! HİÇ CİHAZ EKLENMEDİYSE SEKME GÖRÜNMEZ DURUMDADIR
        children: phones
            .asMap()
            .entries
            .map(
              (e) => Text(
                e.value.name!,
                style: TextStyle(
                    color:
                        selectedTab == e.key ? Colorize.black : Colorize.text),
              ),
            )
            .toList()
            .asMap(),
      ),
    );
  }
}

Widget mySegmentWidget(String text) {
  return InkWell(
    child: Container(
      child: Text(
        text,
        style: TextStyle(fontSize: 25, color: Colors.black),
      ),
    ),
    onTap: () {
      log('message');
    },
  );
}

class HomeActivitiesListView extends StatelessWidget {
  final LangaugeRegister list;
  final List<LastSeenNumbers> phones;
  final int tabIndex;
  const HomeActivitiesListView(
      {Key? key,
      required this.tabIndex,
      required this.phones,
      required this.list})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return phones[tabIndex].events!.isEmpty
        ? Container(
            width: MediaQuery.of(context).size.width,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
            decoration: BoxDecoration(
              color: Colorize.layer,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              children: [
                const Iconify(
                  Carbon.recently_viewed,
                  size: 64.0,
                  color: Colorize.icon,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'nullActivityText'.tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colorize.textSec,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                Text(
                  'nullActivityCaption'.tr(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colorize.icon),
                ),
              ],
            ),
          )
        : ListView(
            padding: EdgeInsets.zero,
            primary: false,
            shrinkWrap: true,
            children: phones[tabIndex]
                .events!
                .map((a) => ActivityCard(
                      phone: phones[tabIndex],
                      activity: a,
                    ))
                .toList());
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 1,
        color: Colorize.primary,
      ),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final LastSeenNumbers phone;
  final Events activity;
  const ActivityCard({Key? key, required this.phone, required this.activity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colorize.layer, borderRadius: BorderRadius.circular(8.0)),
      child: Stack(children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(phone.name!, overflow: TextOverflow.ellipsis),
            Text(
              activity.onlineHour != null ? activity.onlineHour! : "-",
              style: const TextStyle(fontSize: 12.0, color: Colorize.icon),
            )
          ],
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                activity.duraction != null ? activity.duraction! : "-",
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                "activeTime".tr(),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 8.0,
                  color: Colorize.icon,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(activity.offlineDate != null ? activity.offlineDate! : "-",
                  overflow: TextOverflow.ellipsis),
              Text(
                activity.offlineHour != null ? activity.offlineHour! : "-",
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colorize.icon,
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}

class TrialFreePremium extends StatelessWidget {
  final HomeController controller;

  const TrialFreePremium({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Row options(String text) => Row(
          children: [
            const Iconify(AkarIcons.circle_check_fill, color: Colorize.primary),
            const SizedBox(width: 8.0),
            Text(text),
          ],
        );

    return Scaffold(
      body: Banner(
        message: "tryFree".tr().toUpperCase(),
        location: BannerLocation.topEnd,
        color: Colorize.primary,
        textStyle: const TextStyle(
            color: Colorize.black, fontSize: 10.0, fontWeight: FontWeight.w900),
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            standartTitle("freeTrialTitle".tr()),
                            const SizedBox(height: 16.0),
                            options("freeTrialLabel1".tr()),
                            const SizedBox(height: 8.0),
                            options("freeTrialLabel2".tr()),
                            const SizedBox(height: 8.0),
                            options("freeTrialLabel3".tr()),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CupertinoButton(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colorize.primary,
                          onPressed: () {
                            Navigator.pop(context);
                            controller.purchaseIsAvailbleControl();

                            // TODO  8 SAAT PREMİUM DENEME SÜRECİNİ BAŞLAT
                          },
                          child: Text(
                            "freeTrialTryButton".tr(),
                            style: const TextStyle(
                                color: Colorize.black, fontSize: 16.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      standartCaption("freeTrialCaption".tr()),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("close".tr().toUpperCase(),
                        style: const TextStyle(color: Colorize.textSec))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
