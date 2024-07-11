import 'package:final_project/view/screens/analytics/calorie/individual_bar.dart';

class BarData {
  final double sunAmmount;
  final double monAmmount;
  final double tusAmmount;
  final double wedAmmount;
  final double thurAmmount;
  final double friAmmount;
  final double satAmmount;
  List<IndividualBar> barData = [];

  BarData({
    required this.sunAmmount,
    required this.monAmmount,
    required this.tusAmmount,
    required this.wedAmmount,
    required this.thurAmmount,
    required this.friAmmount,
    required this.satAmmount,
  });

  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y: sunAmmount),
      IndividualBar(x: 1, y: monAmmount),
      IndividualBar(x: 2, y: tusAmmount),
      IndividualBar(x: 3, y: wedAmmount),
      IndividualBar(x: 4, y: thurAmmount),
      IndividualBar(x: 5, y: friAmmount),
      IndividualBar(x: 6, y: satAmmount),
    ];
  }
}
