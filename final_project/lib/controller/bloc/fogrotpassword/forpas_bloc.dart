import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forpas_event.dart';
part 'forpas_state.dart';

class ForpasBloc extends Bloc<ForpasEvent, ForpasState> {
  ForpasBloc() : super(ForpasInitial()) {
    on<ForpasRequestedEvent>(_onForgotPasswordRequestedEvent);
  }

  void _onForgotPasswordRequestedEvent(
      ForpasRequestedEvent event, Emitter<ForpasState> emit) async {
    emit(ForpasLoadingstate());
    try {
      final email = event.email;

      if (EmailValidator.validate(email) == false) {
        emit(ForpasFailurestate('Email is not a valid email'));
        return;
      }
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      await Future.delayed(const Duration(seconds: 0), () {
        emit(ForpasSuccessstate(uid: email));
      });
      emit(ForpasInitial());
    } catch (e) {
      emit(ForpasFailurestate(e.toString()));
    }
  }
}
