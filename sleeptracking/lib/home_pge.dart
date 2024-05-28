import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:sensors_plus/sensors_plus.dart';

import 'package:sleeptracking/sleep.dart';
import 'bloc/sleep_bloc.dart';
import 'bloc/sleep_event.dart';
import 'bloc/sleep_state.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SleepBloc _sleepBloc;
  List<SleepData> _sleepData = [];

  @override
  void initState() {
    super.initState();
    _sleepBloc = SleepBloc()..add(LoadSleepDataEvent());

    accelerometerEvents.listen((AccelerometerEvent event) {
      if (_sleepBloc.state is SleepInProgress) {
        if (event.x.abs() < 0.1 && event.y.abs() < 0.1 && event.z.abs() < 0.1) {
          // User is likely stable and possibly asleep
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _sleepBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sleep Tracker'),
        ),
        body: BlocBuilder<SleepBloc, SleepState>(
          builder: (context, state) {
            if (state is SleepInProgress) {
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    _sleepBloc.add(EndSleepEvent());
                  },
                  child: Text('End Sleep'),
                ),
              );
            } else if (state is SleepCompleted) {
              _sleepData = state.sleepData;
              return _buildSleepList();
            } else {
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    _sleepBloc.add(StartSleepEvent());
                  },
                  child: Text('Start Sleep'),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildSleepList() {
    return ListView.builder(
      itemCount: _sleepData.length,
      itemBuilder: (context, index) {
        final record = _sleepData[index];
        final sleepDuration = record.sleepDuration;
        return ListTile(
          title: Text(
            '${DateFormat.yMMMd().add_jm().format(record.startTime)} - ${DateFormat.jm().format(record.endTime)}',
          ),
          subtitle: Text(
            'Duration: ${sleepDuration.inHours} hours ${sleepDuration.inMinutes % 60} minutes',
          ),
        );
      },
    );
  }
}
