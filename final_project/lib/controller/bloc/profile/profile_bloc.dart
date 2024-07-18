import 'dart:async';

import 'package:final_project/controller/apis/user_data_repository.dart';
import 'package:final_project/model/global_variables.dart';
import 'package:final_project/model/user_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<LogoutButtonPressedEvent>(_onLogoutButtonPressedEvent);
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

  FutureOr<void> _updateUserData(
    UpdateUserData event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      GetUserData getUserData = GetUserData();
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
              email1 = event.email,
              Fluttertoast.showToast(msg: 'User Updated successfully')
            }
          : Fluttertoast.showToast(
              msg: 'Something went wrong please try again later');
    } catch (e) {
      emit(ProfileEditorErrorState(error: e.toString()));
    }
  }
}
