import 'dart:developer';

import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:esewa_flutter_sdk/payment_failure.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../controller/apis/user_data_repository.dart';
import '../../../../utils/constants.dart';

class Esewa {
  pay() {
    try {
      EsewaFlutterSdk.initPayment(
          esewaConfig: EsewaConfig(
            clientId: CLIENT_ID,
            secretId: SECRET_KEY,
            environment: Environment.test,
          ),
          esewaPayment: EsewaPayment(
            productId: 'Kushal58',
            productName: 'Kushal',
            productPrice: '10',
            callbackUrl: '',
          ),
          onPaymentSuccess: (EsewaPaymentSuccessResult successResult) {
            log('Success');
            verifyTransactionStatus(successResult);
          },
          onPaymentFailure: (EsewaPaymentFailure failureResult) {
            log('Failure');
          },
          onPaymentCancellation: () {
            log('Cancelled');
          });
    } catch (e) {
      log(e.toString());
    }
  }

  void verifyTransactionStatus(EsewaPaymentSuccessResult result) async {
    Map data = result.toJson();
    GetUserData getUserData = GetUserData();

    var response = await callVerificationApi(data['refId']);
    print("The Response Is: ${response.body}");
    print("The Response Status Code Is: ${response.statusCode}");

    if (response.statusCode.toString() == "200") {
      await getUserData.goPremium();
    } else {
      log("Error");
    }
  }

  callVerificationApi(result) async {
    print("TxnRefd Id: " + result);

    var response = await http.get(
      Uri.parse("https://rc.esewa.com.np/mobile/transaction?txnRefId=$result"),
      headers: {
        'Content-Type': 'application/json',

        //test cred
        'merchantSecret': SECRET_KEY,
        'merchantId': CLIENT_ID,
      },
    );
    print("Call Verification Api: ${response.statusCode}");
    return response;
  }
}
