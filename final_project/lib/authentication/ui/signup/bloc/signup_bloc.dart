import 'package:final_project/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupRequestedEvent>(_onSignupRequestedEvent);
  }

  void _onSignupRequestedEvent(
    SignupRequestedEvent event,
    Emitter<SignupState> emit,
  ) async {
    emit(SignupLoadingstate());
    try {
      final email = event.email;
      final password = event.password;
      final name = event.name;
      final phoneno = event.phoneno;
      final confirmPassword = event.confirmPassword;

      if (email.isEmpty) {
        emit(SignupFailurestate('Email cannot be empty'));
        return;
      } else if (name.isEmpty) {
        emit(SignupFailurestate('Name cannot be empty'));
        return;
      } else if (!email.contains('@')) {
        emit(SignupFailurestate('Invalid email'));
        return;
      } else if (phoneno.isEmpty) {
        emit(SignupFailurestate('Phone number cannot be empty'));
        return;
      } else if (phoneno.length < 10) {
        emit(SignupFailurestate(
            'Phone number must be at least 10 characters long'));
        return;
      } else if (password.isEmpty) {
        emit(SignupFailurestate('Password cannot be empty'));
        return;
      } else if (password.length < 6) {
        emit(SignupFailurestate('Password must be at least 6 characters long'));
        return;
      } else if (confirmPassword != password) {
        emit(SignupFailurestate('Passwords do not match'));
        return;
      }
      await Future.delayed(const Duration(seconds: 1), () {
        Get.snackbar('Signup Success', 'Welcome $email');
        Get.offAll(() => const HomeScreen());
        emit(SignupSuccessstate(uid: '$email-$password'));
      });
      emit(SignupInitial());
    } catch (e) {
      emit(SignupFailurestate(e.toString()));
    }
  }
}
