import 'package:final_project/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

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

      if (email.isEmpty) {
        emit(LoginFailurestate('Email cannot be empty'));
        return;
      } else if (!email.contains('@')) {
        emit(LoginFailurestate('Invalid email'));
        return;
      } else if (password.isEmpty) {
        emit(LoginFailurestate('Password cannot be empty'));
        return;
      } else if (password.length < 6) {
        emit(LoginFailurestate('Password must be at least 6 characters long'));
        return;
      }
      await Future.delayed(const Duration(seconds: 1), () {
        Get.snackbar('Login Success', 'Welcome $email');
        Get.offAll(() => const HomeScreen());
        emit(LoginSuccessstate(uid: '$email-$password'));
      });
      emit(LoginInitial());
    } catch (e) {
      emit(LoginFailurestate(e.toString()));
    }
  }
}
