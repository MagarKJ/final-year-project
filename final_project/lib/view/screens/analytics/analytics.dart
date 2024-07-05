import 'package:final_project/controller/bloc/analytics/analytics_bloc.dart';
import 'package:final_project/view/screens/analytics/calorie/calorie_graph.dart';
import 'package:final_project/view/screens/analytics/calorie/calorie_graphhh.dart';

import 'package:final_project/view/screens/analytics/step_data.dart';
import 'package:final_project/view/screens/analytics/water/water_graph.dart';
import 'package:final_project/widgets/custom_titile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        body: BlocBuilder<AnalyticsBloc, AnalyticsState>(
          builder: (context, state) {
            if (state is AnalyticsInitial) {
              BlocProvider.of<AnalyticsBloc>(context).add(AnalyticsLoadEvent());
            } else if (state is AnalyticsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AnalyticsErrorState) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is AnalyticsLoadedState) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomTitle(
                        fontSize: 15,
                        title: 'Calories Consumed',
                      ),
                      CalorieGraphhh(analytics: state.weeklySummary),
                      const CustomTitle(
                        fontSize: 15,
                        title: 'Water Consumed',
                      ),
                      WaterGraph(
                        analytics: state.weeklySummary,
                      ),
                      const CustomTitle(
                        fontSize: 15,
                        title: 'Calories Consumed',
                      ),
                      Container(
                        height: 200,
                        child: CalorieGraph(
                          analtics: state.weeklySummary,
                        ),
                      ),
                      StepDataPage(analytics: state.weeklySummary)
                    ],
                  ),
                ),
              );
            }
            return Container(
              child: const Text('No Data'),
            );
          },
        ));
  }
}
