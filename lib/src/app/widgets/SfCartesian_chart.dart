import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wpfamilylastseen/src/app/constants/colors.dart';
import 'package:wpfamilylastseen/src/domain/entities/last_seen_number.dart';

class SfCartesianChartDetail extends StatelessWidget {
  final LastSeenNumber lastSeenNumber;

  const SfCartesianChartDetail({super.key, required this.lastSeenNumber});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            tooltipBehavior: TooltipBehavior(
              enable: true,
            ),
            series: <ChartSeries<Graphics, String>>[
              LineSeries<Graphics, String>(
                color: Colorize.primary,
                dataSource: lastSeenNumber.graphics!,
                xValueMapper: (Graphics x, _) => x.hour,
                yValueMapper: (Graphics y, _) =>
                    num.parse(y.duraction!.replaceAll(":", ".")),
                dataLabelSettings: DataLabelSettings(isVisible: true),
              )
            ]),
      ],
    );
  }
}
