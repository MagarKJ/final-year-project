import 'package:final_project/controller/bloc/analytics/analytics_bloc.dart';
import 'package:final_project/utils/constants.dart';
import 'package:final_project/utils/global_variables.dart';
import 'package:final_project/view/screens/analytics/calorie/calorie_graphhh.dart';
import 'package:final_project/view/screens/analytics/carbs.dart';
import 'package:final_project/view/screens/analytics/fat.dart';
import 'package:final_project/view/screens/analytics/protein.dart';
import 'package:final_project/view/screens/analytics/sodium.dart';

import 'package:final_project/view/screens/analytics/step_data.dart';
import 'package:final_project/view/screens/analytics/water_graph.dart';
import 'package:final_project/widgets/custom_titile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Analytics extends StatelessWidget {
  const Analytics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          surfaceTintColor: whiteColor,
          backgroundColor: whiteColor,
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
                      isPremium == 1
                          ? StepDataPage(
                              analytics: state.weeklySummary,
                            )
                          : const SizedBox.shrink(),
                      CalorieGraphhh(analytics: state.weeklySummary),
                      CarbsGraph(analytics: state.weeklySummary),
                      ProteinGraph(analytics: state.weeklySummary),
                      FatsGraph(analytics: state.weeklySummary),
                      SodiumGraph(analytics: state.weeklySummary),
                      WaterGraph(
                        analytics: state.weeklySummary,
                      ),
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
