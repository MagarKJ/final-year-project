part of 'forpas_bloc.dart';

@immutable
sealed class ForpasEvent {}

final class ForpasRequestedEvent extends ForpasEvent {
  final String email;

  ForpasRequestedEvent({
    required this.email,
  });
}
