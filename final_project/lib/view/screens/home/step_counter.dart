import 'dart:async';
import 'dart:developer';

import 'package:final_project/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sensors/flutter_sensors.dart';
import 'package:get/get.dart';
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

  late String bodyType;
  late String bodyGoal;
  late String bloodPressure;
  late int sugarLevel;
  int maxSteps = 10000; // Default value for maxSteps

  final double stepThreshold = 0.2;
  late SharedPreferences _prefs;
  late DateTime _lastActiveTime;
  late StreamSubscription _accelSubscription =
      StreamController().stream.listen((_) {});

  @override
  void initState() {
    super.initState();
    startListening();
  }

  Future<void> startListening() async {
    log('startListening ma xiryo');
    final permissionStatus = await Permission.activityRecognition.request();
    // final permissionStatus = await Permission.sensors.request();
    log(permissionStatus.toString());
    if (permissionStatus.isGranted) {
      final stream = await SensorManager().sensorUpdates(
        sensorId: Sensors.LINEAR_ACCELERATION,
        interval: Sensors.SENSOR_DELAY_NORMAL,
      );
      _accelSubscription = stream.listen((sensorEvent) {
        final double y = sensorEvent.data[1];
        if ((_previousY < -stepThreshold && y >= -stepThreshold) ||
            (_previousY > stepThreshold && y <= stepThreshold)) {
          setState(() {
            _stepCount++;
          });
          _saveStepCount();
          _checkLastActiveTime();
        }
        _previousY = y;
      });
    } else if (permissionStatus.isPermanentlyDenied) {
      openAppSettings();
    } else {
      print('Sensor permission not granted.');
    }
  }

  Future<void> _saveStepCount() async {
    await _prefs.setInt('stepCount', _stepCount);
  }

  Future<void> _checkLastActiveTime() async {
    final now = DateTime.now();
    if (_lastActiveTime.year != now.year ||
        _lastActiveTime.month != now.month ||
        _lastActiveTime.day != now.day) {
      await _resetStepCount();
      _lastActiveTime = now;
      await _prefs.setInt('lastActiveTime', now.millisecondsSinceEpoch);
    }
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
            animation: true,
            backgroundColor: Colors.black,
            percent: (_stepCount / maxSteps)
                .clamp(0.0, 1.0), // Set the percent directly here
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
