part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

final class SignupRequestedEvent extends SignupEvent {
  final String email;
  final String name;
  final String age;
  final String phoneno;
  final String password;
  final String sex;
  final String weight;
  final String ethnicity;
  final String bodytype;
  final String bodygoal;
  final String bloodPressue;
  final String bloodSugar;

  SignupRequestedEvent({
    required this.email,
    required this.name,
    required this.phoneno,
    required this.age,
    required this.password,
    required this.sex,
    required this.weight,
    required this.bloodPressue,
    required this.bloodSugar,
    required this.bodygoal,
    required this.bodytype,
    required this.ethnicity,
  });
}

final class GoogleSignupRequestedEvent extends SignupEvent {}
