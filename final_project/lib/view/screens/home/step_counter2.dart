import 'dart:async';

// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:final_project/utils/global_variables.dart';
import 'package:flutter/material.dart';

import 'package:flutter_sensors/flutter_sensors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepCounter2 extends StatefulWidget {
  const StepCounter2({super.key});

  @override
  State<StepCounter2> createState() => _StepCounterState();
}

class _StepCounterState extends State<StepCounter2> {
  int _stepCount = 0;
  int diastolic = 0;
  int systolic = 0;
  double _previousY = 0.0;
  double _filteredY = 0.0;
  late SharedPreferences _prefs;
  late DateTime _lastActiveTime;
  late StreamSubscription _accelSubscription =
      StreamController().stream.listen((_) {});

  int maxSteps = 10000; // Default value for maxSteps
  final double stepThreshold = 0.05; // Adjusted step detection threshold
  final double alpha = 0.6; // Low-pass filter coefficient
  final Duration stepTimeInterval =
      const Duration(milliseconds: 50); // Minimum interval between steps

  List<int> splitBloodPressure(String bloodPressure) {
    // Split the input string by '/'
    List<String> parts = bloodPressure.split('/');

    // Convert the split parts to integers
    int systolic = int.parse(parts[0]);
    int diastolic = int.parse(parts[1]);

    // Return the values as a list
    return [systolic, diastolic];
  }

  int calculateStepGoal() {
    int baseSteps = 8000;

    // Adjust based on body type
    switch (bodytype) {
      case 'morbidly obese':
        baseSteps += 1000;
        break;
      case 'obese':
        baseSteps += 1500;
        break;
      case 'overweight':
        baseSteps += 2000;
        break;
      case 'average':
        baseSteps += 2500;
        break;
      case 'lean':
        baseSteps += 3000;
        break;
    }

    // Adjust based on body goals
    switch (bodygoal) {
      case 'lean':
        baseSteps += 2000;
        break;
      case 'muscular':
        baseSteps += 1500;
        break;
      case 'slim':
        baseSteps += 2500;
        break;
      case 'fatloss':
        baseSteps += 3000;
        break;
    }

    // Adjust based on age
    if (age < 30) {
      baseSteps += 1000;
    } else if (age >= 30 && age <= 50) {
      baseSteps += 500;
    } else {
      baseSteps += 0;
    }

    // Adjust based on weight
    if (double.parse(weight) < 60) {
      baseSteps += 1000;
    } else if (double.parse(weight) >= 60 && double.parse(weight) < 80) {
      baseSteps += 500;
    } else {
      baseSteps -= 500;
    }

    // Adjust based on blood pressure (hypothetical values, you'd adjust according to specific health guidelines)
    if (systolic < 120 && diastolic < 80) {
      baseSteps += 500;
    } else if ((systolic >= 120 && systolic < 140) ||
        (diastolic >= 80 && diastolic < 90)) {
      baseSteps += 0;
    } else if (systolic >= 140 || diastolic >= 90) {
      baseSteps -= 1000;
    }

    // Adjust based on blood sugar levels (again, hypothetical)
    if (double.parse(bloodSugar) < 100) {
      baseSteps += 500;
    } else if (double.parse(bloodSugar) >= 100 &&
        double.parse(bloodSugar) < 126) {
      baseSteps += 0;
    } else {
      baseSteps -= 1000;
    }

    // Ensure the step count is reasonable
    if (baseSteps < 3000) {
      baseSteps = 3000;
    } else if (baseSteps > 15000) {
      baseSteps = 15000;
    }

    return baseSteps;
  }

  @override
  void initState() {
    super.initState();
    List<int> values = splitBloodPressure(bloodPressure);
    systolic = values[0];
    diastolic = values[1];

    print('Systolic: ${values[0]}');
    print('Diastolic: ${values[1]}');
    _initializePreferences();
    maxSteps = calculateStepGoal();
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
        color: const Color(0xFFADD8E6).withOpacity(.3),
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
            // percent: 0.1,
            percent: (_stepCount / maxSteps).clamp(0.0, 1.0),
            center: Text(
              // '1000',
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
