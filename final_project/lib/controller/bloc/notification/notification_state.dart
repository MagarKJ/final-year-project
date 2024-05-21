part of 'notification_bloc.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

final class NotificationLoadingstate extends NotificationState {}

final class NotificationFailurestate extends NotificationState {
  final String error;

  NotificationFailurestate(this.error);
}

final class NotificationSuccessstate extends NotificationState {
  final String messgae;

  NotificationSuccessstate({required this.messgae});
}
