// import 'package:shared_preferences/shared_preferences.dart';

// Future<void> saveSleepData(DateTime startTime, DateTime endTime) async {
//   final prefs = await SharedPreferences.getInstance();
//   prefs.setString('sleepStart', startTime.toIso8601String());
//   prefs.setString('sleepEnd', endTime.toIso8601String());
// }

// Future<Map<String, DateTime>> getSleepData() async {
//   final prefs = await SharedPreferences.getInstance();
//   String? start = prefs.getString('sleepStart');
//   String? end = prefs.getString('sleepEnd');
//   return {
//     'start': DateTime.parse(start!),
//     'end': DateTime.parse(end!),
//   };
// }
