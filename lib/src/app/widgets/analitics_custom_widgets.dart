import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:wpfamilylastseen/src/app/pages/home/home_controller.dart';
import 'package:wpfamilylastseen/src/app/widgets/SfCartesian_chart.dart';
import 'package:wpfamilylastseen/src/domain/entities/last_seen_number.dart'
    as num;
import '../../domain/entities/last_seen_number.dart';
import '../constants/colors.dart';

class ChartWidget extends StatefulWidget {
  final LastSeenNumber lastSeenNumber;
  final int index;
  final HomeController controller;
  const ChartWidget({
    Key? key,
    required this.lastSeenNumber,
    required this.index,
    required this.controller,
  }) : super(key: key);

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
              color: Colorize.layer,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                right: 16,
                left: 16,
                top: 16,
                bottom: 8,
              ),
              child: SfCartesianChartDetail(
                lastSeenNumber: widget.lastSeenNumber,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AnaliticsOnlineGraph extends StatelessWidget {
  final num.LastSeenNumber phone;
  final int selectedOnlineGraphTab;
  final Function(int) onValueChanged;
  final HomeController controller;
  const AnaliticsOnlineGraph({
    Key? key,
    required this.phone,
    required this.selectedOnlineGraphTab,
    required this.onValueChanged,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: Colorize.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              "activeTime".tr(),
              style: TextStyle(
                  color: selectedOnlineGraphTab == 0
                      ? Colorize.black
                      : Colorize.text),
            ),
          ),
        ),
        ChartWidget(
          lastSeenNumber: phone,
          index: selectedOnlineGraphTab,
          controller: controller,
        ),
      ],
    );
  }
}

class AnaliticsWeeklyData extends StatelessWidget {
  final bool onWeekly;
  final Function(bool) onWeeklySlideChanged;
  final DateTime selectedDate;
  final Function(DateTime) dateChanged;
  final num.LastSeenNumber lastSeenNumber;
  const AnaliticsWeeklyData({
    Key? key,
    required this.onWeekly,
    required this.onWeeklySlideChanged,
    required this.dateChanged,
    required this.selectedDate,
    required this.lastSeenNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnaliticsWeeklyDataTabBar(
          onWeekly: onWeekly,
          selectedDate: selectedDate,
          onWeeklySlideChanged: onWeeklySlideChanged,
          dateChanged: dateChanged,
        ),
        AnaliticsActivitiesListView(
            phones: lastSeenNumber, tabIndex: onWeekly ? 1 : 0),
      ],
    );
  }
}

class AnaliticsWeeklyDataTabBar extends StatelessWidget {
  final bool? onWeekly;
  final Function(bool)? onWeeklySlideChanged;
  final Function(DateTime)? dateChanged;
  final DateTime? selectedDate;
  const AnaliticsWeeklyDataTabBar({
    Key? key,
    this.onWeekly,
    this.onWeeklySlideChanged,
    this.dateChanged,
    this.selectedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: CupertinoSlidingSegmentedControl(
            backgroundColor: Colorize.layer,
            padding: const EdgeInsets.all(4.0),
            groupValue: onWeekly,
            thumbColor: Colorize.primary,
            children: {
              false: Text("daily".tr(),
                  style: TextStyle(
                      color:
                          onWeekly == false ? Colorize.black : Colorize.text)),
              true: Text("weekly".tr(),
                  style: TextStyle(
                      color:
                          onWeekly == true ? Colorize.black : Colorize.text)),
            },
            onValueChanged: (value) {
              onWeeklySlideChanged!(value!);
            },
          ),
        ),
        /* InkWell(
          // aktivitelerin tarih filtresi
          onTap: () => showAnaliticsDatePopUp(
              context, selectedDate ?? DateTime.now(), dateChanged),
          borderRadius: BorderRadius.circular(4.0),
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colorize.layer,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              selectedDate != null
                  ? '${selectedDate!.day.toString()} '
                  : '${DateTime.now().day.toString()}',
              style: const TextStyle(color: Colorize.primary),
            ),
          ),
        ),*/
      ],
    );
  }
}

class AnaliticsActivitiesListView extends StatelessWidget {
  final num.LastSeenNumber? phones;
  final int? tabIndex;
  const AnaliticsActivitiesListView(
      {Key? key, required this.tabIndex, required this.phones})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return phones == null
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
                    "nullActivityText".tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colorize.textSec,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                Text(
                  "nullActivityCaption".tr(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colorize.icon),
                ),
              ],
            ),
          )
        : ListView(primary: false, shrinkWrap: true, children: [
            AnaliticsActivityCard(
              phoneName: phones!.name!,
              weeklyEvents: phones!.weeklyEvents!,
              dailyEvents: phones!.dailyEvents,
              index: tabIndex,
            ),
          ]);
  }
}

class AnaliticsActivityCard extends StatelessWidget {
  final String? phoneName;
  final List<num.WeeklyEvents>? weeklyEvents;
  final List<num.DailyEvents>? dailyEvents;
  final int? index;

  const AnaliticsActivityCard({
    Key? key,
    this.phoneName,
    this.weeklyEvents,
    this.dailyEvents,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return index != 1
        ? dailyEvents != null &&
                dailyEvents!.length != 0 &&
                dailyEvents!.last.events != null &&
                dailyEvents!.last.events!.length != 0
            ? ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: dailyEvents!.last.events!.length,
                itemBuilder: (context, index) {
                  return ActiveDetailContainer(
                    events: dailyEvents!.last.events![index],
                    phoneName: phoneName,
                  );
                },
              )
            : Container()
        : weeklyEvents != null &&
                weeklyEvents!.length != 0 &&
                weeklyEvents!.last.events != null &&
                weeklyEvents!.last.events!.length != 0
            ? ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: weeklyEvents!.last.events!.length,
                itemBuilder: (context, index) {
                  return ActiveDetailContainer(
                    events: weeklyEvents!.last.events![index],
                    phoneName: phoneName,
                  );
                },
              )
            : Container();
  }
}

class ActiveDetailContainer extends StatelessWidget {
  final String? phoneName;
  final num.Events? events;

  const ActiveDetailContainer({super.key, this.phoneName, this.events});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colorize.layer, borderRadius: BorderRadius.circular(8.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(phoneName != null ? phoneName! : "",
                  overflow: TextOverflow.ellipsis),
              Text(
                events!.onlineDate != null ? events!.onlineDate! : "",
                style: const TextStyle(fontSize: 12.0, color: Colorize.icon),
              )
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                events!.duraction != null ? events!.duraction! : "",
                style: TextStyle(
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
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                  DateFormat("dd/MMM")
                      .format(DateTime.parse(events!.onlineDate!)),
                  overflow: TextOverflow.ellipsis),
              Text(
                events!.offlineHour != null ? events!.offlineHour! : "",
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colorize.icon,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

popUpContainer(BuildContext context, Widget child) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) =>
        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 4.0,
          sigmaY: 4.0,
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            padding:
                const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colorize.black,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: child,
          ),
        ),
      );
    }),
  );
}

showAnaliticsDatePopUp(context, selectedDate, onDateTimeChanged) =>
    popUpContainer(
      context,
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            child: CupertinoDatePicker(
              initialDateTime: selectedDate,
              dateOrder: DatePickerDateOrder.dmy,
              maximumDate: DateTime.now(),
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: onDateTimeChanged,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: CupertinoButton(
              borderRadius: BorderRadius.circular(8.0),
              color: Colorize.primary,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "filter".tr(),
                style: const TextStyle(color: Colorize.black, fontSize: 16.0),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("close".tr().toUpperCase(),
                  style: const TextStyle(color: Colorize.textSec))),
        ],
      ),
    );
