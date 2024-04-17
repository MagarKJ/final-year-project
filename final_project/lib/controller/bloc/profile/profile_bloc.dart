import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<LogoutButtonPressedEvent>(_onLogoutButtonPressedEvent);
    on<FetchUserDataEvent>(_onFetchUserDataEvent);
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

  void _onFetchUserDataEvent(
    FetchUserDataEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileEditorLoadingState());

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        emit(ProfileEditorLoadedState(userData: userData.data().toString()));
      } else {
        throw Exception('No user logged in');
      }
    } catch (e) {
      emit(ProfileEditorErrorState(error: e.toString()));
    }
  }
}
