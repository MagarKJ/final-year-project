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

      age = user['age'];
      prefs.setInt('age', age ?? 0);
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
      prefs.setBool('Login', true);
      Get.offAll(() => MyBottomNavigationBar());
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
