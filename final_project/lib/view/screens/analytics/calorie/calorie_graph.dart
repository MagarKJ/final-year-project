import 'package:final_project/model/analtics_model.dart';
import 'package:final_project/utils/constants.dart';
import 'package:final_project/view/screens/analytics/calorie/bar_data.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CalorieGraph extends StatefulWidget {
  final List<AnalticsModel> analtics;
  const CalorieGraph({
    super.key,
    required this.analtics,
  });

  @override
  State<CalorieGraph> createState() => _GraphState();
}

class _GraphState extends State<CalorieGraph> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      sunAmmount: double.parse(widget.analtics[0].calories),
      monAmmount: double.parse(widget.analtics[1].calories),
      tusAmmount: double.parse(widget.analtics[2].calories),
      wedAmmount: double.parse(widget.analtics[3].calories),
      thurAmmount: double.parse(widget.analtics[4].calories),
      friAmmount: double.parse(widget.analtics[5].calories),
      satAmmount: double.parse(widget.analtics[6].calories),
    );
    myBarData.initializeBarData();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BarChart(
            BarChartData(
              maxY: 3000,
              minY: 0,
              gridData: FlGridData(
                show: true,
                drawHorizontalLine: true,
                drawVerticalLine: false,
                horizontalInterval: 1000,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: myGrey,
                    strokeWidth: 1,
                  );
                },
              ),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                show: true,
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1000,
                    reservedSize: 25,
                  ),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                rightTitles: const AxisTitles(
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
                          color: calorieColor,
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

  List<String> extractMonthAndDayList(List<String> dateList) {
    List<String> formattedDates = [];
    for (String createdAt in dateList) {
      DateTime dateTime = DateTime.parse(createdAt);
      String month = dateTime.month.toString().padLeft(2, '0');
      String day = dateTime.day.toString().padLeft(2, '0');
      String formattedDate = '$month-$day';
      formattedDates.add(formattedDate);
    }
    return formattedDates;
  }

  Widget getBottomTitles(
    double value,
    TitleMeta meta,
  ) {
    const style = TextStyle(
      color: Colors.black,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    );
    String text1 = extractMonthAndDay(widget.analtics[0].date);
    String text2 = extractMonthAndDay(widget.analtics[1].date);
    String text3 = extractMonthAndDay(widget.analtics[2].date);
    String text4 = extractMonthAndDay(widget.analtics[3].date);
    String text5 = extractMonthAndDay(widget.analtics[4].date);
    String text6 = extractMonthAndDay(widget.analtics[5].date);
    String text7 = extractMonthAndDay(widget.analtics[6].date);

    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text(text1, style: style);
        break;
      case 1:
        text = Text(text2, style: style);
        break;
      case 2:
        text = Text(text3, style: style);
        break;
      case 3:
        text = Text(text4, style: style);
        break;
      case 4:
        text = Text(text5, style: style);
        break;
      case 5:
        text = Text(text6, style: style);
        break;
      case 6:
        text = Text(text7, style: style);
        break;
      default:
        text = const Text('');
    }
    return SideTitleWidget(axisSide: meta.axisSide, child: text);
  }
}
