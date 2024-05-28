import 'package:final_project/utils/constants.dart';
import 'package:final_project/view/screens/analytics/water/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SleepGraph extends StatefulWidget {
  const SleepGraph({super.key});

  @override
  State<SleepGraph> createState() => _GraphState();
}

class _GraphState extends State<SleepGraph> {
  List<double> weeklySummary = [
    8,
    7,
    12,
    9,
    14,
    6,
    8,
  ];

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      sunAmmount: weeklySummary[0],
      monAmmount: weeklySummary[1],
      tusAmmount: weeklySummary[2],
      wedAmmount: weeklySummary[3],
      thurAmmount: weeklySummary[4],
      friAmmount: weeklySummary[5],
      satAmmount: weeklySummary[6],
    );
    myBarData.initializeBarData();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: sleepColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BarChart(
            BarChartData(
              maxY: 24,
              minY: 0,
              gridData: FlGridData(
                show: true,
                drawHorizontalLine: true,
                drawVerticalLine: false,
                horizontalInterval: 4,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: black,
                    strokeWidth: 1,
                  );
                },
              ),
              borderData: FlBorderData(show: false),
              titlesData: const FlTitlesData(
                show: true,
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 4,
                    reservedSize: 25,
                  ),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                  showTitles: false,
                )),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: getBottomTitles,
                  ),
                ),
              ),
              barGroups: myBarData.barData
                  .map(
                    (data) => BarChartGroupData(
                      x: data.x,
                      barRods: [
                        BarChartRodData(
                          toY: data.y,
                          color: black,
                          width: 10,
                          borderRadius: BorderRadius.circular(2),
                          // backDrawRodData: BackgroundBarChartRodData(
                          //   show: true,
                          //   toY: 1600,
                          //   color: Colors.grey[300],
                          // ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('Sun', style: style);
      break;
    case 1:
      text = const Text('Mon', style: style);
      break;
    case 2:
      text = const Text('Tus', style: style);
      break;
    case 3:
      text = const Text('Wed', style: style);
      break;
    case 4:
      text = const Text('Thur', style: style);
      break;
    case 5:
      text = const Text('Fri', style: style);
      break;
    case 6:
      text = const Text('Sat', style: style);
      break;
    default:
      text = const Text('');
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
