import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

//if any of these three is entered no need to check for the other two
      if (email.isEmpty && name.isEmpty && phoneno.isEmpty) {
        emit(SignupFailurestate('Email, phone or name cannot be empty'));
        return;
      }
      //if email khali xa name ya phone hanyo vane email ko validity check garna parena
      else if (email.isNotEmpty && EmailValidator.validate(email) == false) {
        emit(SignupFailurestate('Invalid email'));
        return;
      }
      // if phoneno khali xa vane aaru 2 ta hanna parenaa tesai le validity check garna parena
      else if (phoneno.isNotEmpty && phoneno.length < 10) {
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
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await Future.delayed(const Duration(seconds: 1), () {
        Get.snackbar('Signup Success', 'Welcome $email');

        emit(SignupSuccessstate(uid: '$email-$password'));
      });
      emit(SignupInitial());
    } catch (e) {
      emit(SignupFailurestate(e.toString()));
    }
  }
}
