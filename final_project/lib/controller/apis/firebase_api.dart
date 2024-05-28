import 'dart:developer' as developer;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../view/screens/home/notification.dart';

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

  //initialize the notification
  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        handleMessage(context, message);
      },
    );
  }

  //initialize the firebase

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      developer.log('Got a message whilst in the foreground!');
      developer.log('Message data: ${message.data}');
      developer.log(message.notification?.title ?? 'No title');
      developer.log(message.notification?.body ?? 'No body');

      initLocalNotifications(context, message);
      showNotification(message);
    });
  }

//show notification
  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random().nextInt(1000).toString(),
      'High Importance Channel',
      importance: Importance.max,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'This channel is used for important notifications',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    Future.delayed(
      Duration.zero,
      () {
        _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails,
        );
      },
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
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      
      handleMessage(context, message);
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
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Notifications()));
    }
  }
}
