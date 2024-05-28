import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<NotificationLoadedEvent>(_onNotificationLoadedEvent);
  }

  void _onNotificationLoadedEvent(
    NotificationLoadedEvent event,
    Emitter<NotificationState> emit,
  ) async {
    log('start bho bloc');
    emit(NotificationLoadingstate());
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('messages').get();

      List<Map<String, dynamic>> messages = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      emit(NotificationSuccessstate(messgae: messages));
      log("Firebase bata aako notification${messages.toString()}");
    } catch (e) {
      emit(NotificationFailurestate('Error: $e'));
    }
  }
}
