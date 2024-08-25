import 'dart:async';
import 'dart:developer';

import 'package:final_project/model/paymentdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../apis/user_data_repository.dart';

part 'payment_bloc_event.dart';
part 'payment_bloc_state.dart';

class PaymentBlocBloc extends Bloc<PaymentBlocEvent, PaymentBlocState> {
  PaymentBlocBloc() : super(PaymentBlocInitial()) {
    on<PaymentBlocInitialEvent>(_onPaymentBlocInitialEvent);
  }

  FutureOr<void> _onPaymentBlocInitialEvent(
    PaymentBlocInitialEvent event,
    Emitter<PaymentBlocState> emit,
  ) async {
    emit(PaymentBlocLoading());
    try {
      GetUserData getUserData = GetUserData();
      dynamic user = await getUserData.getPaymentDetails();
      List<dynamic> payemnt = user['Statement'];
      List<PaymentDetails> payemnts =
          payemnt.map((payemnt) => PaymentDetails.fromJson(payemnt)).toList();
      emit(PaymentBlocLoaded(paymentDataModel: payemnts));
    } catch (e) {
      emit(PaymentBlocError(message: e.toString()));
      log(e.toString());
    }
  }
}
