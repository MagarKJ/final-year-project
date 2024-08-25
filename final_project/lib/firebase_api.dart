import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:final_project/utils/constants.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'view/screens/home/notification.dart';

// Future<void> handlerBackgroundMessage(RemoteMessage message) async {
//   print('Title: ${message.notification?.title}');
//   print('Body: ${message.notification?.body}');
//   print('Payload: ${message.data}');
//   log('Handling a background message ${message.messageId}');
// }

class FireBaseAPi {
  //create an instance of FirebaseMessaging
  final firebaseMessaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //initialize the notification
  Future<void> initLocalNotifications() async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {},
      // onDidReceiveNotificationResponse: (payload) {
      //   handleMessage(context, message);
      // },
    );
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName',
          importance: Importance.max),
    );
  }

  Future scheduleNotification1({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledNotificationDateTime,
  }) async {
    return _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(
        scheduledNotificationDateTime,
        tz.local,
      ),
      androidAllowWhileIdle: true,
      notificationDetails(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future showNotification1(
      {int id = 0, String? title, String? body, String? payload}) async {
    return _flutterLocalNotificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  //initialize the firebase

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      developer.log('Got a message whilst in the foreground!');
      developer.log('Message data: ${message.data}');
      developer.log(message.notification?.title ?? 'No title');
      developer.log(message.notification?.body ?? 'No body');

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        // developer.log("notifications title: ${notification.title}");
        // developer.log("notifications body: ${notification.body}");
        // developer.log('count: ${android?.count ?? ''}');
        // developer.log('data: ${message.data.toString()}');

        if (message.data.isNotEmpty) {
          // developer.log('Message data payload: ${message.data}');
          // Play sound
          final player = AudioPlayer();
          player.play(AssetSource('audio.wav'));

          Get.snackbar(
            message.notification!.title.toString(),
            message.notification!.body.toString(),
            backgroundColor: Colors.grey[200],
            colorText: black,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 3),
            onTap: (value) {
              Get.back();
              handleMessage(context, message);
            },
          );
        }
      }

      initLocalNotifications();
      showNotification(message);
    });
  }

//request user for permission
  void requestNotificationPermission() async {
    NotificationSettings setting = await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (setting.authorizationStatus == AuthorizationStatus.authorized) {
      developer.log('User granted permission');
    } else {
      developer.log('User declined or has not accepted permission');
    }
  }

//generate device token
  Future<void> getDeviceToken() async {
    final fCMToken = await firebaseMessaging.getToken();
    developer.log('FCM Token: $fCMToken');
  }

  //check if token expired
  void isTokenRefresh() async {
    firebaseMessaging.onTokenRefresh.listen((event) {
      developer.log('Token Refreshed: $event');
      event.toString();
    });
  }

//show notification
  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'default_channel',
      'Default Channel',
      importance: Importance.max,
      showBadge: true,
      playSound: true,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: 'This channel is used for important notifications',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      ticker: 'ticker',
      sound: const RawResourceAndroidNotificationSound('audio'),
      enableVibration: true,
      enableLights: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      Random().nextInt(1000),
      message.notification?.title.toString() ?? 'No Title',
      message.notification?.body.toString() ?? 'No Body',
      notificationDetails,
      payload: jsonEncode(message.data),
    );
  }

//when app is in background and user clicks on notification
  Future<void> setupInteractMessage(
    BuildContext context,
  ) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      handleMessage(context, initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }

// when app is in background and user clicks on notification
  void handleMessage(BuildContext context, RemoteMessage message) {
    developer.log('Handling a background message: ${message.messageId}');
    FirebaseFirestore.instance.collection('messages').add({
      'messageId': message.messageId,
      'data': message.data,
      'notification': message.notification != null
          ? {
              'title': message.notification!.title,
              'body': message.notification!.body,
            }
          : null,
    });
    if (message.data['type'] == 'notification') {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const Notifications()));
    }
  }

  Future<void> forgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> scheduleNotification(
      String title, String body, DateTime scheduledDate) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Kathmandu'));

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your_channel_id', 'your_channel_name',
            importance: Importance.max,
            priority: Priority.max,
            ticker: 'ticker',
            playSound: true,
            enableLights: true,
            enableVibration: true,
            sound: RawResourceAndroidNotificationSound('audio'));

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'default',
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    final scheduledDateTime = tz.TZDateTime.from(scheduledDate, tz.local);

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      scheduledDateTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      // androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelScheduledReminder(String deletedNote) async {
    int notificationId = deletedNote.hashCode;
    // developer.log('Notification ID to cancel: $notificationId');

    await _flutterLocalNotificationsPlugin.cancel(notificationId);
  }
}
