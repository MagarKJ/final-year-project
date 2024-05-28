import 'dart:async';
import 'dart:developer';

// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';

import 'package:flutter_sensors/flutter_sensors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepCounter extends StatefulWidget {
  const StepCounter({super.key});

  @override
  State<StepCounter> createState() => _StepCounterState();
}

class _StepCounterState extends State<StepCounter> {
  int _stepCount = 0;
  double _previousY = 0.0;
  double _filteredY = 0.0;
  late SharedPreferences _prefs;
  late DateTime _lastActiveTime;
  late StreamSubscription _accelSubscription =
      StreamController().stream.listen((_) {});

  final int maxSteps = 10000; // Default value for maxSteps
  final double stepThreshold = 0.35; // Adjusted step detection threshold
  final double alpha = 0.8; // Low-pass filter coefficient
  final Duration stepTimeInterval =
      Duration(milliseconds: 250); // Minimum interval between steps

  @override
  void initState() {
    super.initState();
    _initializePreferences();
    startListening();
  }

  Future<void> _initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _stepCount = _prefs.getInt('stepCount') ?? 0;
    int lastActiveTimestamp = _prefs.getInt('lastActiveTime') ??
        DateTime.now().millisecondsSinceEpoch;
    _lastActiveTime = DateTime.fromMillisecondsSinceEpoch(lastActiveTimestamp);
  }

  Future<void> startListening() async {
    // ...

    // AndroidAlarmManager.periodic(const Duration(minutes: 1), 0, countSteps);
  // }

  // Future<void> countSteps() async {
    final permissionStatus = await Permission.activityRecognition.request();
    if (permissionStatus.isGranted) {
      final stream = await SensorManager().sensorUpdates(
        sensorId: Sensors.LINEAR_ACCELERATION,
        interval: Sensors.SENSOR_DELAY_NORMAL,
      );
      _accelSubscription = stream.listen((sensorEvent) {
        final double y = sensorEvent.data[1];
        _filteredY = _filteredY * alpha + y * (1.0 - alpha);

        if ((_previousY < -stepThreshold && _filteredY >= -stepThreshold) ||
            (_previousY > stepThreshold && _filteredY <= stepThreshold)) {
          _registerStep();
        }
        _previousY = _filteredY;
      });
    } else if (permissionStatus.isPermanentlyDenied) {
      openAppSettings();
    } else {
      print('Sensor permission not granted.');
    }
  }

  void _registerStep() {
    final now = DateTime.now();
    if (now.difference(_lastActiveTime) > stepTimeInterval) {
      setState(() {
        _stepCount++;
      });
      _saveStepCount();
      _lastActiveTime = now;
    }
  }

  Future<void> _saveStepCount() async {
    await _prefs.setInt('stepCount', _stepCount);
    await _prefs.setInt(
        'lastActiveTime', _lastActiveTime.millisecondsSinceEpoch);
  }

  Future<void> _resetStepCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('stepCount', 0);
    setState(() {
      _stepCount = 0;
    });
  }

  @override
  void dispose() {
    _accelSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFADD8E6).withOpacity(.3),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircularPercentIndicator(
            radius: 80.0,
            lineWidth: 20,
            backgroundColor: Colors.black,
            percent: (_stepCount / maxSteps).clamp(0.0, 1.0),
            center: Text(
              _stepCount < maxSteps ? ' $_stepCount' : 'Goal Achieved! 🎉',
              style: TextStyle(
                fontFamily: GoogleFonts.montserrat().fontFamily,
                fontSize: 21,
                color: Colors.blue[900],
              ),
            ),
            progressColor: Colors.white,
          ),
          const SizedBox(height: 7),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Journey of Steps',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                'Daily Goal: $maxSteps',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
