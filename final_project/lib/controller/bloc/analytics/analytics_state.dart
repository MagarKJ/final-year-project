part of 'analytics_bloc.dart';

@immutable
sealed class AnalyticsState {}

final class AnalyticsInitial extends AnalyticsState {}

final class AnalyticsLoadingState extends AnalyticsState {}

final class AnalyticsLoadedState extends AnalyticsState {
  final List<AnalticsModel> weeklySummary;

  AnalyticsLoadedState({
    required this.weeklySummary,
  });
}

final class AnalyticsErrorState extends AnalyticsState {
  final String message;

  AnalyticsErrorState(this.message);
}
