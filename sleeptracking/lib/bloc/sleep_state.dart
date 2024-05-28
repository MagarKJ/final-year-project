import '../sleep.dart';

abstract class SleepState {
  const SleepState();

  List<Object?> get props => [];
}

class SleepInitial extends SleepState {}

class SleepInProgress extends SleepState {
  final DateTime startTime;

  SleepInProgress(this.startTime);

  @override
  List<Object?> get props => [startTime];
}

class SleepCompleted extends SleepState {
  final List<SleepData> sleepData;

  SleepCompleted(this.sleepData);

  @override
  List<Object?> get props => [sleepData];
}
