import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleeptracking/bloc/sleep_bloc.dart';
import 'package:sleeptracking/home_pge.dart';

void main()  {
  // WidgetsFlutterBinding.ensureInitialized();
  // await AndroidAlarmManager.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SleepBloc(),
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
