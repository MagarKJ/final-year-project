import 'package:final_project/view/screens/analytics/calorie/calorie_graph.dart';
import 'package:final_project/view/screens/analytics/sleep/graph.dart';
import 'package:final_project/view/screens/analytics/water/water_graph.dart';
import 'package:final_project/widgets/custom_titile.dart';
import 'package:flutter/material.dart';

class Analytics extends StatelessWidget {
  const Analytics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const CustomTitle(
            fontSize: 25,
            isAppbar: true,
            title: "Analystics",
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTitle(
                  fontSize: 15,
                  title: 'Calories Consumed',
                ),
                Container(
                  height: 200,
                  child: const CalorieGraph(),
                ),
                const CustomTitle(
                  fontSize: 15,
                  title: 'Water Consumed',
                ),
                Container(
                  height: 200,
                  child: const WaterGraph(),
                ),
                const CustomTitle(
                  fontSize: 15,
                  title: 'Sleep Time',
                ),
                Container(
                  height: 200,
                  child: const SleepGraph(),
                ),
                const CustomTitle(
                  fontSize: 15,
                  title: 'Calories Consumed',
                ),
                Container(
                  height: 200,
                  child: const CalorieGraph(),
                ),
              ],
            ),
          ),
        ));
  }
}
