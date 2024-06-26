part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

final class SignupRequestedEvent extends SignupEvent {
  final String email;
  final String name;
  final String age;
  final String phoneno;
  final String password;
  final String confirmPassword;

  SignupRequestedEvent({
    required this.email,
    required this.name,
    required this.phoneno,
    required this.age,
    required this.password,
    required this.confirmPassword,
  });
}

final class GoogleSignupRequestedEvent extends SignupEvent {
  
}
