part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class LoginRequestedEvent extends LoginEvent {
  final String email;
  final String password;

  LoginRequestedEvent({
    required this.email,
    required this.password,
  });
}

final class GoogleLoginRequestedEvent extends LoginEvent {}

