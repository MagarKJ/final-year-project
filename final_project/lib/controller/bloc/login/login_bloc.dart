import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginRequestedEvent>(_onLoginRequestedEvent);
    on<GoogleLoginRequestedEvent>(_onGoogleLoginRequestedEvent);
  }

  void _onLoginRequestedEvent(
    LoginRequestedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoadingstate());
    try {
      final email = event.email;
      final password = event.password;

      if (EmailValidator.validate(email) == false) {
        emit(LoginFailurestate('Email is not a valid email'));
        return;
      } else if (password.isEmpty) {
        emit(LoginFailurestate('Password cannot be empty'));
        return;
      } else if (password.length < 6) {
        emit(LoginFailurestate('Password must be at least 6 characters long'));
        return;
      }

      //Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the user data from Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      await Future.delayed(const Duration(seconds: 1), () {
        Get.snackbar('Login Success', 'Welcome $email');

        emit(LoginSuccessstate(uid: '$email-$password'));
      });
      emit(LoginInitial());
    } catch (e) {
      print('Error: $e');
      String errorMessage;
      if (e is FirebaseAuthException) {
        print('FirebaseAuthException code: ${e.code}');
        switch (e.code) {
          case 'invalid-credential':
            errorMessage = 'Email or password is incorrect';
            break;
          case 'too-many-requests':
            errorMessage = 'Too many requests. Try again later';
            break;
          default:
            errorMessage = 'An error occurred';
        }
      } else {
        errorMessage = 'An error occurred';
      }
      emit(LoginFailurestate(errorMessage));
    }
  }

  void _onGoogleLoginRequestedEvent(
    GoogleLoginRequestedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(GoogleLoginLoadingstate());

    try {
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn().signIn().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          emit(GoogleLoginFailurestate('Timeout'));
          return null;
        },
      );
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);

      await Future.delayed(const Duration(seconds: 1), () {
        Get.snackbar('Login Success', 'Welcome ${googleUser.email}');
        emit(GoogleLoginSuccessstate(uid: googleUser.email));
      });
    } catch (e) {
      emit(GoogleLoginFailurestate(e.toString()));
    }
  }
}
