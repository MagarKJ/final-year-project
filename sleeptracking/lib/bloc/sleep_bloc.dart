import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../sleep.dart';
import 'sleep_event.dart';
import 'sleep_state.dart';
import 'dart:convert';

class SleepBloc extends Bloc<SleepEvent, SleepState>  {
  SleepBloc() : super(SleepInitial());

  Stream<SleepState> mapEventToState(SleepEvent event) async* {
    final prefs = await SharedPreferences.getInstance();
    if (event is StartSleepEvent) {
      yield SleepInProgress(DateTime.now());
    } else if (event is EndSleepEvent && state is SleepInProgress) {
      final sleepStartTime = (state as SleepInProgress).startTime;
      final sleepEndTime = DateTime.now();
      final newSleepData = SleepData(sleepStartTime, sleepEndTime);

      List<String>? storedData = prefs.getStringList('sleepData') ?? [];
      storedData.add(jsonEncode(newSleepData.toJson()));

      await prefs.setStringList('sleepData', storedData);

      final updatedSleepData = storedData
          .map((data) => SleepData.fromJson(jsonDecode(data)))
          .toList();

      yield SleepCompleted(updatedSleepData);
    } else if (event is LoadSleepDataEvent) {
      List<String>? storedData = prefs.getStringList('sleepData') ?? [];
      final sleepData = storedData
          .map((data) => SleepData.fromJson(jsonDecode(data)))
          .toList();
      yield SleepCompleted(sleepData);
    }
  }
}
