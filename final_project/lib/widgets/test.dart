import 'dart:developer';

import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  String formattedTime = '';
  DateTime dateTime = DateTime(2024, 8, 24, 17, 38, 0);
  @override
  void initState() {
    DateTime now = DateTime.now();
    formattedTime = DateFormat('HH:mm:ss').format(now);
    log('message: $now');
    log('current time : $formattedTime');
    callApiAt12();
    callApi();
    super.initState();
  }

  void callApiAt12() {
    if (DateTime.now().isAfter(dateTime)) {
      dateTime = dateTime.add(const Duration(minutes: 1));
      log('$dateTime');
      log('1');
    } else {
      log('time vaxainba');
    }
  }

  void callApi() {
    final cron = Cron();

    // Schedule to run every 24 hours at midnight (00:00)
    cron.schedule(Schedule.parse('0 0 * * *'), () async {
      print('Running task every 24 hours at midnight');
      // Add your API call here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Widget'),
      ),
      body: const Center(
        child: Text('Test Widget'),
      ),
    );
  }
}
