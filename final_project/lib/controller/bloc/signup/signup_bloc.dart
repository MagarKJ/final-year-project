import 'dart:developer';

import 'package:final_project/controller/apis/register_response.dart';
import 'package:final_project/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../view/bottom_navigtion_bar.dart';
import '../../apis/user_data_repository.dart';

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
    RegisterRepository registerRepository = RegisterRepository();
    GetUserData getUserData = GetUserData();
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
      log('get user aaba');

      dynamic user = await getUserData.getUserData(token: token);
      dynamic userdata = user['user'];
      log('1');
      name = userdata['name'];
      prefs.setString('name', name);
      log('2');
      userId = userdata['user_id'];
      prefs.setInt('userId', userId);
      log('3');
      email1 = userdata['email'];
      prefs.setString('email', email1);
      log('4');
      bloodPressure = userdata['bloodPressure'];
      prefs.setString('bloodPressure', bloodPressure);
      log('5');
      bloodSugar = userdata['bloodSugar'];
      prefs.setString('bloodSugar', bloodSugar);
      log('6');
      isPremium = userdata['isPremium'];
      prefs.setInt('isPremium', isPremium);

      log('7');
      age = userdata['age'];
      prefs.setInt('age', age ?? 0);
      log('8');
      phoneno = userdata['phone'];
      prefs.setString('phone', phoneno);
      log('9');
      sex = userdata['sex'];
      prefs.setString('sex', sex);
      log('10');
      weight = userdata['weight'];
      prefs.setString('weight', weight);
      log('11');
      ethnicity = userdata['ethnicity'];
      prefs.setString('ethnicity', ethnicity);
      log('12');
      bodytype = userdata['bodyType'];
      prefs.setString('bodyType', bodytype);
      log('13');
      bodygoal = userdata['bodyGoal'];
      prefs.setString('bodyGoal', bodygoal);
      log('aba navigation');
      log(name);
      log(email1);
      Get.offAll(() => MyBottomNavigationBar());
    } catch (e) {
      log(e.toString());
      emit(SignupFailurestate(e.toString()));
    }
  }
}
