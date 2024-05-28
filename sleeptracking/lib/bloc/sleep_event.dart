

abstract class SleepEvent {
  const SleepEvent();

  List<Object?> get props => [];
}

class StartSleepEvent extends SleepEvent {}

class EndSleepEvent extends SleepEvent {}

class LoadSleepDataEvent extends SleepEvent {}
