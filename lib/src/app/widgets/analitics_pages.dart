import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wpfamilylastseen/src/app/pages/home/home_controller.dart';
import 'package:wpfamilylastseen/src/domain/entities/last_seen_number.dart';
import 'analitics_custom_widgets.dart';

class AnaliticsPage extends StatefulWidget {
  final LastSeenNumber? lastSeenNumber;
  final HomeController? controller;

  const AnaliticsPage(
      {Key? key, required this.lastSeenNumber, required this.controller})
      : super(key: key);

  @override
  State<AnaliticsPage> createState() => _AnaliticsPageState();
}

class _AnaliticsPageState extends State<AnaliticsPage> {
  int selectedOnlineGraphTab = 0;
  bool onWeekly = false;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("activities".tr())),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              AnaliticsOnlineGraph(
                phone: widget.lastSeenNumber!,
                selectedOnlineGraphTab: selectedOnlineGraphTab,
                onValueChanged: (int value) {
                  setState(() {
                    selectedOnlineGraphTab = value;
                  });
                },
                controller: widget.controller!,
              ),
              AnaliticsWeeklyData(
                onWeekly: onWeekly,
                selectedDate:
                    selectedDate != null ? selectedDate! : DateTime.now(),
                onWeeklySlideChanged: (bool v) {
                  setState(() {
                    onWeekly = v;
                  });
                },
                dateChanged: (DateTime date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
                lastSeenNumber: widget.lastSeenNumber!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
