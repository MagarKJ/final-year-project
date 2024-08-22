part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class LogoutButtonPressedEvent extends ProfileEvent {}

final class UpdateUserPhoto extends ProfileEvent {
  final XFile image;

  UpdateUserPhoto({
    required this.image,
  });
}

final class UpdateUserData extends ProfileEvent {
  final String name;
  final String age;
  final String phoneno;
  final String email;
  final String sex;
  final String weight;
  final String ethnicity;
  final String bodytype;
  final String bodygoal;
  final String bloodPressue;
  final String bloodSugar;

  UpdateUserData({
    required this.email,
    required this.name,
    required this.phoneno,
    required this.age,
    required this.sex,
    required this.weight,
    required this.bloodPressue,
    required this.bloodSugar,
    required this.bodygoal,
    required this.bodytype,
    required this.ethnicity,
  });
}

final class GoPremium extends ProfileEvent {}
