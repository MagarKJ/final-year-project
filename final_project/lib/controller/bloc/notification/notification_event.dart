part of 'notification_bloc.dart';

@immutable
sealed class NotificationEvent {}

final class NotificationLoadedEvent extends NotificationEvent{}
