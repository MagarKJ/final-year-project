import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:final_project/controller/apis/register_response.dart';
import 'package:final_project/model/global_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../view/bottom_navigtion_bar.dart';
import '../../apis/user_data_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupRequestedEvent>(_onSignupRequestedEvent);
    on<GoogleSignupRequestedEvent>(_onGoogleSignupRequestedEvent);
  }

  void _onSignupRequestedEvent(
    SignupRequestedEvent event,
    Emitter<SignupState> emit,
  ) async {
    RegisterRepository registerRepository = RegisterRepository();
    GetUserData getUserData = GetUserData();
    emit(SignupLoadingstate());
    try {
      dynamic registerResponse = await registerRepository.register(
          email: event.email,
          password: event.password,
          name: event.name,
          phoneno: event.phoneno,
          age: event.age,
          sex: event.sex,
          weight: event.weight,
          ethnicity: event.ethnicity,
          bodytype: event.bodytype,
          bodygoal: event.bodygoal,
          bloodPressue: event.bloodPressue,
          bloodSugar: event.bloodSugar);
      token = registerResponse;

      dynamic userdata = await getUserData.getUserData(token: token);
      name = userdata['name'];
      userId = userdata['user_id'];
      email1 = userdata['email'];

      log(name);
      log(email1);
      Get.to(() => MyBottomNavigationBar());

      //if any of these three is entered no need to check for the other two
      // if (email.isEmpty && name.isEmpty && phoneno.isEmpty) {
      //   emit(SignupFailurestate('Email, phone or name cannot be empty'));
      //   return;
      // }
      // //if email khali xa name ya phone hanyo vane email ko validity check garna parena
      // else if (email.isNotEmpty && EmailValidator.validate(email) == false) {
      //   emit(SignupFailurestate('Invalid email'));
      //   return;
      // }
      // // if phoneno khali xa vane aaru 2 ta hanna parenaa tesai le validity check garna parena
      // else if (phoneno.isNotEmpty && phoneno.length < 10) {
      //   emit(SignupFailurestate(
      //       'Phone number must be at least 10 characters long'));
      //   return;
      // } else if (password.isEmpty) {
      //   emit(SignupFailurestate('Password cannot be empty'));
      //   return;
      // } else if (password.length < 6) {
      //   emit(SignupFailurestate('Password must be at least 6 characters long'));
      //   return;
      // } else if (confirmPassword != password) {
      //   emit(SignupFailurestate('Passwords do not match'));
      //   return;
      // }
      // UserCredential userCredential =
      //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );

      // FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(userCredential.user!.uid)
      //     .set({
      //   'name': name,
      //   'email': email,
      //   'phoneno': phoneno,
      //   'age': age,
      //   'password': password,
      //   'uid': userCredential.user!.uid,
      // });
      // log('Data Inserted');

      // await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      // log('Email Verification Sent');
      // Get.snackbar(
      //     'Verification Email has been sent', 'Please verify your email');

      // await Future.delayed(const Duration(seconds: 1), () {
      //   Get.snackbar('Signup Success', 'Welcome $email');

      //   emit(SignupSuccessstate(uid: '$email-$password'));
      // });

      // emit(SignupInitial());
    } catch (e) {
      emit(SignupFailurestate(e.toString()));
    }
  }

  void _onGoogleSignupRequestedEvent(
    GoogleSignupRequestedEvent event,
    Emitter<SignupState> emit,
  ) async {
    emit(GoogleSignupLoadingState());

    try {
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn().signIn().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          emit(SignupFailurestate('Google Signin Timeout'));
          return null;
        },
      );
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential

      await FirebaseAuth.instance.signInWithCredential(credential);

      log('Google Signup Success');
      await Future.delayed(const Duration(seconds: 1), () {
        Get.snackbar('Signup Success', 'Welcome');
        emit(GoogleSignupSuccessstate(uid: 'Google'));
      });
    } catch (e) {
      log(e.toString());
      emit(SignupFailurestate(e.toString()));
    }
  }
}
