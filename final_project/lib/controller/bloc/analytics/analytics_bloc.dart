import 'dart:async';
import 'dart:developer';

import 'package:final_project/controller/apis/analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/analtics_model.dart';

part 'analytics_event.dart';
part 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  AnalyticsBloc() : super(AnalyticsInitial()) {
    on<AnalyticsLoadEvent>(_onAnalyticsLoadEvent);
  }

  FutureOr<void> _onAnalyticsLoadEvent(
    AnalyticsLoadEvent event,
    Emitter<AnalyticsState> emit,
  ) async {
    AnalyticsRepository analyticsRepository = AnalyticsRepository();
    try {
      emit(AnalyticsLoadingState());
      dynamic analytics = await analyticsRepository.fetchAnalytics();
      List<dynamic> analyticsData = analytics['Records'];

      List<AnalticsModel> analyticsModel = analyticsData
          .map((analyticsData) => AnalticsModel.fromJson(analyticsData))
          .toList();

      emit(AnalyticsLoadedState(weeklySummary: analyticsModel));
    } catch (e) {
      emit(
        AnalyticsErrorState(e.toString()),
      );
      log(e.toString());
    }
  }
}
