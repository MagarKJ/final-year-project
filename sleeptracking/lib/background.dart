// import 'package:flutter/material.dart';
// import 'package:background_fetch/background_fetch.dart';

// void backgroundFetchHeadlessTask(HeadlessTask task) async {
//   String taskId = task.taskId;
//   bool timeout = task.timeout;
//   if (timeout) {
//     BackgroundFetch.finish(taskId);
//     return;
//   }
//   // Handle your background task logic here
//   BackgroundFetch.finish(taskId);
// }

// void main() {
//   runApp(MyApp());
//   BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: SleepTracker(),
//     );
//   }
// }

// class SleepTracker extends StatefulWidget {
//   @override
//   _SleepTrackerState createState() => _SleepTrackerState();
// }

// class _SleepTrackerState extends State<SleepTracker> {
//   @override
//   void initState() {
//     super.initState();
//     initBackgroundFetch();
//   }

//   void initBackgroundFetch() async {
//     BackgroundFetch.configure(
//         BackgroundFetchConfig(
//           minimumFetchInterval: 15,
//           stopOnTerminate: false,
//           enableHeadless: true,
//         ),
//         _onBackgroundFetch)
//       .then((int status) {
//         print('[BackgroundFetch] configure success: $status');
//       })
//       .catchError((e) {
//         print('[BackgroundFetch] configure ERROR: $e');
//       });
//   }

//   void _onBackgroundFetch(String taskId) async {
//     // Handle background fetch event
//     print("[BackgroundFetch] Event received: $taskId");
//     BackgroundFetch.finish(taskId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sleep Tracker'),
//       ),
//       body: Center(
//         child: Text('Tracking Sleep in Background'),
//       ),
//     );
//   }
// }
