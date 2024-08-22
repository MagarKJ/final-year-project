import 'dart:async';
import 'dart:developer';

import 'package:final_project/controller/apis/user_data_repository.dart';
import 'package:final_project/model/user_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/global_variables.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<LogoutButtonPressedEvent>(_onLogoutButtonPressedEvent);
    on<UpdateUserPhoto>(_updateUserPhoto);
    on<UpdateUserData>(_updateUserData);
  }

  void _onLogoutButtonPressedEvent(
      LogoutButtonPressedEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      emit(ProfileLogoutState());
    } catch (e) {
      emit(ProfileErrorState(message: e.toString()));
    }
  }

  FutureOr<void> _updateUserPhoto(
    UpdateUserPhoto event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      GetUserData getUserData = GetUserData();
      emit(ProfileEditorLoadingState());
      ApiResponse user = await getUserData.updateUserPhoto(
        image: event.image,
      );
      user.statusCode == 200
          ? {
              image = user.data['user']['photo_name'],
              Fluttertoast.showToast(msg: 'User Updated successfully'),
              log(user.data['user']['photo_name']),
            }
          : Fluttertoast.showToast(
              msg: 'Something went wrong please try again later');
    } catch (e) {
      emit(ProfileEditorErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _updateUserData(
    UpdateUserData event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      GetUserData getUserData = GetUserData();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      emit(ProfileEditorLoadingState());
      ApiResponse user = await getUserData.updateUserData(
        name: event.name,
        age: event.age,
        phoneno: event.phoneno,
        email: event.email,
        sex: event.sex,
        weight: event.weight,
        ethnicity: event.ethnicity,
        bodytype: event.bodytype,
        bodygoal: event.bodygoal,
        bloodPressue: event.bloodPressue,
        bloodSugar: event.bloodSugar,
      );
      user.statusCode == 200
          ? {
              name = event.name,
              prefs.setString('name', name),
              email1 = event.email,
              prefs.setString('email', email1),
              bloodPressure = event.bloodPressue,
              prefs.setString('bloodPressure', bloodPressure),
              bloodSugar = event.bloodSugar,
              prefs.setString('bloodSugar', bloodSugar),
              isPremium = user.data['user']['isPremium'],
              prefs.setInt('isPremium', isPremium),
              isGoogleLogin = user.data['user']['isGoogle'],
              prefs.setInt('isGoogle', isGoogleLogin),
              age = event.age,
              prefs.setInt('age', age),
              phoneno = event.phoneno,
              prefs.setString('phone', phoneno),
              sex = event.sex,
              prefs.setString('sex', sex),
              weight = event.weight,
              prefs.setString('weight', weight),
              ethnicity = event.ethnicity,
              prefs.setString('ethnicity', ethnicity),
              bodytype = event.bodytype,
              prefs.setString('bodyType', bodytype),
              bodygoal = event.bodygoal,
              prefs.setString('bodyGoal', bodygoal),
              Fluttertoast.showToast(msg: 'User Updated successfully')
            }
          : Fluttertoast.showToast(
              msg: 'Something went wrong please try again later');
    } catch (e) {
      emit(ProfileEditorErrorState(error: e.toString()));
    }
  }
}
