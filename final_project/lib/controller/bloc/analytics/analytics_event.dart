part of 'analytics_bloc.dart';

@immutable
sealed class AnalyticsEvent {}

final class AnalyticsLoadEvent extends AnalyticsEvent {}
