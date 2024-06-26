part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}
final class LoginLoadingstate extends LoginState {}

final class LoginSuccessstate extends LoginState {
  final String uid;

  LoginSuccessstate({required this.uid});
}

final class LoginFailurestate extends LoginState {
  final String error;

  LoginFailurestate(this.error);
}

final class GoogleLoginSuccessstate extends LoginState {
  final String uid;

  GoogleLoginSuccessstate({required this.uid});
}
final class GoogleLoginFailurestate extends LoginState {
  final String error;

  GoogleLoginFailurestate(this.error);
}

final class GoogleLoginLoadingstate extends LoginState {}
 