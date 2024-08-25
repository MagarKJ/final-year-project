import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:final_project/controller/apis/user_data_repository.dart';
import 'package:final_project/model/user_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/paymentdetails.dart';
import '../../../utils/global_variables.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<LogoutButtonPressedEvent>(_onLogoutButtonPressedEvent);
    on<UpdateUserPhoto>(_updateUserPhoto);
    on<UpdateUserData>(_updateUserData);
    on<PurchaseHistoryLoad>(_onPurchaseHistoryLoad);
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
      dynamic userdata = await getUserData.updateUserData(
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
      // log(userdata['user']);
      log('1');
      name = userdata['user']['name'];
      prefs.setString('name', name);
      log('2');
      userId = userdata['user']['user_id'];
      prefs.setInt('userId', userId);
      log('3');
      email1 = userdata['user']['email'];
      prefs.setString('email', email1);
      log('4');
      bloodPressure = userdata['user']['bloodPressure'];
      prefs.setString('bloodPressure', bloodPressure);
      log('5');
      bloodSugar = userdata['user']['bloodSugar'];
      prefs.setString('bloodSugar', bloodSugar);
      log('6');
      isPremium = userdata['user']['isPremium'];
      prefs.setInt('isPremium', isPremium);
      log('7');
      String ageString = userdata['user']['age'];
      age = int.tryParse(ageString);

      prefs.setInt('age', age);
      log('8');
      phoneno = userdata['user']['phone'];
      prefs.setString('phone', phoneno);
      log('9');
      sex = userdata['user']['sex'];
      prefs.setString('sex', sex);
      log('10');
      weight = userdata['user']['weight'];
      prefs.setString('weight', weight);
      log('11');
      ethnicity = userdata['user']['ethnicity'];
      prefs.setString('ethnicity', ethnicity);
      log('12');
      bodytype = userdata['user']['bodyType'];
      prefs.setString('bodyType', bodytype);
      log('13');
      bodygoal = userdata['user']['bodyGoal'];
      prefs.setString('bodyGoal', bodygoal);

      userdata['message'] == 'User updated successfully'
          ? {
              Fluttertoast.showToast(
                  msg: 'User Data Updated Sucessfully',
                  backgroundColor: Colors.green),
              isPremium = 1,
            }
          : Fluttertoast.showToast(
              msg: 'Something Went Wrong Please try Again',
              backgroundColor: Colors.red,
            );
    } catch (e) {
      log(e.toString());
      emit(ProfileEditorErrorState(error: e.toString()));
    }
  }

  void _onPurchaseHistoryLoad(
    PurchaseHistoryLoad event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      GetUserData getUserData = GetUserData();

      dynamic user = await getUserData.getPaymentDetails();
      List<dynamic> payemnt = user['Statement'];
      List<PaymentDetails> payemnts =
          payemnt.map((payemnt) => PaymentDetails.fromJson(payemnt)).toList();
      PaymentDetailLoadedstate(payemnt: payemnts);
    } catch (e) {
      log(e.toString());
    }
  }
}
