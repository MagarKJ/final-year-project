import 'package:final_project/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../model/analtics_model.dart';

class ProteinGraph extends StatefulWidget {
  final List<AnalticsModel> analytics;
  const ProteinGraph({Key? key, required this.analytics}) : super(key: key);

  @override
  _StepDataPageState createState() => _StepDataPageState();
}

class _StepDataPageState extends State<ProteinGraph> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 350,
        child: SfCartesianChart(
          primaryXAxis: const CategoryAxis(title: AxisTitle(text: 'Days')),
          primaryYAxis: const NumericAxis(title: AxisTitle(text: 'Protein')),
          series: [
            LineSeries<AnalticsModel, String>(
              dataSource: widget.analytics,
              xValueMapper: (AnalticsModel data, _) =>
                  extractMonthAndDay(data.date),
              yValueMapper: (AnalticsModel data, _) =>
                  double.parse(data.protein),
              name: 'Protein',
            ),
          ],
          title: const ChartTitle(
              text: 'Protein Consumed', alignment: ChartAlignment.near),
          crosshairBehavior: CrosshairBehavior(
            enable: true, // Set to true to enable crosshair
            lineType: CrosshairLineType
                .both, // You can customize the line type as needed
            lineColor: Colors.grey, // Customize the line color
            lineWidth: 0.5, // Customize the line width
            shouldAlwaysShow:
                true, // Set to true if you want the crosshair to always show
            activationMode:
                ActivationMode.singleTap, // Set the activation mode as needed
          ),
        ));
  }
}
