part of 'forpas_bloc.dart';

@immutable
sealed class ForpasState {}

final class ForpasInitial extends ForpasState {}

final class ForpasLoadingstate extends ForpasState {}

final class ForpasFailurestate extends ForpasState {
  final String error;

  ForpasFailurestate(this.error);
}

final class ForpasSuccessstate extends ForpasState {
  final String uid;

  ForpasSuccessstate({required this.uid});
}
