import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginRequestedEvent>(_onLoginRequestedEvent);
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

      // Access the data
      // String userEmail = userData['email'];
      // String userPhone = userData['phoneno'];
      // String userName = userData['name'];
      // String userAge = userData['age'];
      // Access other fields as needed

      await Future.delayed(const Duration(seconds: 1), () {
        Get.snackbar('Login Success', 'Welcome $email');

        emit(LoginSuccessstate(uid: '$email-$password'));
      });
      emit(LoginInitial());
    } catch (e) {
      print('Error: $e');
      emit(LoginFailurestate('An error occurred'));
      //   String errorMessage;
      //   if (e is FirebaseAuthException) {
      //     print('FirebaseAuthException code: ${e.code}');
      //     switch (e.code) {
      //       case 'user-not-found':
      //         errorMessage = 'No user found for that email.';
      //         break;
      //       case 'wrong-password':
      //         errorMessage = 'Wrong password provided for that user.';
      //         break;
      //       default:
      //         errorMessage = 'An error occurred';
      //     }
      //   } else {
      //     errorMessage = 'An error occurred';
      //   }
      //   emit(LoginFailurestate(errorMessage));
    }
  }
}
