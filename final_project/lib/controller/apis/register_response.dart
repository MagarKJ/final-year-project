import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:final_project/controller/apis/api.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterRepository {
  API api = API();

  Future<dynamic> register({
    required dynamic email,
    required dynamic password,
    required dynamic name,
    required dynamic phoneno,
    required dynamic age,
    required dynamic sex,
    required dynamic weight,
    required dynamic ethnicity,
    required dynamic bodytype,
    required dynamic bodygoal,
    required dynamic bloodPressue,
    required dynamic bloodSugar,
  }) async {
    var value = {
      "email": email,
      "password": password,
      "name": name,
      "phone": phoneno,
      "age": age,
      "sex": sex,
      "weight": weight,
      "ethnicity": ethnicity,
      "bodyType": bodytype,
      "bodyGoal": bodygoal,
      "bloodPressure": bloodPressue,
      "bloodSugar": bloodSugar,
    };
    try {
      var response = await api.sendRequest.post(
        '/api/auth/register',
        data: value,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        String token = data['access_token'];

        return token;
      } else {
        Fluttertoast.showToast(msg: 'Failed to register');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> loginWithGoogle() async {
    try {
      Response response = await api.sendRequest.get('/api/auth/google');
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        String token = data['access_token'];
        return token;
      } else {
        Fluttertoast.showToast(msg: 'Failed to login with google');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
