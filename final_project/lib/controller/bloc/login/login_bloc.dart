import 'dart:async';
import 'dart:developer';

import 'package:final_project/controller/apis/login_repository.dart';
import 'package:final_project/controller/apis/user_data_repository.dart';
import 'package:final_project/utils/global_variables.dart';
import 'package:final_project/view/bottom_navigtion_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    LoginRepository loginRepository = LoginRepository();
    GetUserData getUserData = GetUserData();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    emit(LoginLoadingstate());
    try {
      final email = event.email;
      final password = event.password;
      log('email: email');
      log('repo start');
      dynamic loginResponse = await loginRepository.login(
        email: email,
        password: password,
      );
      token = loginResponse;
      prefs.setString('token', token);

      dynamic userdata = await getUserData.getUserData(token: token);
      dynamic user = userdata['user'];

      name = user['name'];
      prefs.setString('name', name);
      userId = user['user_id'];
      prefs.setInt('userId', userId);
      email1 = user['email'];
      prefs.setString('email', email1);
      image = user['photo_name'];
      prefs.setString('photo_name', image);
      bloodPressure = user['bloodPressure'];
      prefs.setString('bloodPressure', bloodPressure);
      bloodSugar = user['bloodSugar'];
      prefs.setString('bloodSugar', bloodSugar);
      isPremium = user['isPremium'];
      prefs.setInt('isPremium', isPremium);
      // isGoogleLogin = user['google_id'];
      // prefs.setInt('google_id', isGoogleLogin);
      age = user['age'];
      prefs.setInt('age', age);
      phoneno = user['phone'];
      prefs.setString('phone', phoneno);
      sex = user['sex'];
      prefs.setString('sex', sex);
      weight = user['weight'];
      prefs.setString('weight', weight);
      ethnicity = user['ethnicity'];
      prefs.setString('ethnicity', ethnicity);
      bodytype = user['bodyType'];
      prefs.setString('bodyType', bodytype);
      bodygoal = user['bodyGoal'];
      prefs.setString('bodyGoal', bodygoal);

      log('aba navigate garna lageko');
      Get.offAll(() => MyBottomNavigationBar());
      // if (EmailValidator.validate(email) == false) {
      //   emit(LoginFailurestate('Email is not a valid email'));
      //   return;
      // } else if (password.isEmpty) {
      //   emit(LoginFailurestate('Password cannot be empty'));
      //   return;
      // } else if (password.length < 6) {
      //   emit(LoginFailurestate('Password must be at least 6 characters long'));
      //   return;
      // }

      //Firebase Authentication
      // UserCredential userCredential =
      //     await FirebaseAuth.instance.signInWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );

      // // Get the user data from Firestore
      // await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(userCredential.user!.uid)
      //     .get();
      // await Future.delayed(const Duration(seconds: 1), () {
      //   Get.snackbar('Login Success', 'Welcome $email');

      //   emit(LoginSuccessstate(uid: '$email-$password'));
      // });
      // emit(LoginInitial());
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
      log('google sign in error $e');
      emit(GoogleLoginFailurestate(e.toString()));
    }
  }
}
