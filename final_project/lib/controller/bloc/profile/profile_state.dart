part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoadingState extends ProfileState {}

final class ProfileLoadedState extends ProfileState {
  final String user;
  ProfileLoadedState({required this.user});
}

final class ProfileErrorState extends ProfileState {
  final String message;
  ProfileErrorState({required this.message});
}
final class ProfileLogoutState extends ProfileState {}