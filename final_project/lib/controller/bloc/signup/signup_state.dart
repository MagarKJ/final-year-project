part of 'signup_bloc.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupLoadingstate extends SignupState {}

final class SignupSuccessstate extends SignupState {
  final String uid;

  SignupSuccessstate({required this.uid});
}

final class SignupFailurestate extends SignupState {
  final String error;

  SignupFailurestate(this.error);
}

final class GoogleSignupSuccessstate extends SignupState {
  final String uid;

  GoogleSignupSuccessstate({required this.uid});
}

final class GoogleSignupFailurestate extends SignupState {
  final String error;

  GoogleSignupFailurestate(this.error);
}

final class GoogleSignupLoadingState extends SignupState {}
