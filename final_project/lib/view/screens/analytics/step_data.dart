import 'package:final_project/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../model/analtics_model.dart';

class StepDataPage extends StatefulWidget {
  final List<AnalticsModel> analytics;
  const StepDataPage({Key? key, required this.analytics}) : super(key: key);

  @override
  _StepDataPageState createState() => _StepDataPageState();
}

class _StepDataPageState extends State<StepDataPage> {
  // late List<Map<String, dynamic>> _stepData = [

  // ];

  bool _dataLoaded = true; // Add a flag to track data loading

  @override
  void initState() {
    super.initState();
    // fetchStepData();
  }

  // Future<void> fetchStepData() async {
  //   // final stepData = await SQLHelper.getAllStepTrackerData();
  //   setState(() {
  //     _stepData = stepData;
  //     _dataLoaded = true; // Set the flag to true when data is loaded
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 300,
        child:
            // _dataLoaded // Check the flag to determine whether to show the chart or not
            //     ?
            SfCartesianChart(
          primaryXAxis: CategoryAxis(title: AxisTitle(text: 'Days')),
          primaryYAxis: NumericAxis(title: AxisTitle(text: 'Steps')),
          // series: <ChartSeries<Map<String, dynamic>, String>>[
          //   LineSeries<Map<String, dynamic>, String>(
          //     dataSource: _stepData,
          //     xValueMapper: (datum, _) =>
          //         (datum['id'] ?? '').toString(),
          //     yValueMapper: (datum, _) => datum['steps'] as int,
          //   ),
          // ],

          series: [
            // widget.analytics,
            LineSeries<AnalticsModel, String>(
              dataSource: widget.analytics,
              xValueMapper: (AnalticsModel data, _) =>
                  extractMonthAndDay(data.date),
              yValueMapper: (AnalticsModel data, _) => double.parse(data.fat),
              name: 'Carbs',
              // Enable data label
              // dataLabelSettings: DataLabelSettings(isVisible: true),
            ),
          ],
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
        )
        // : const Center(
        //     child: Text(
        //       'No step data available',
        //       style: TextStyle(fontSize: 16),
        //     ),
        //   ),
        );
  }
}
