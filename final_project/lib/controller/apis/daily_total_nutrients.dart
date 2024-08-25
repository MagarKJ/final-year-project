import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:final_project/controller/apis/api.dart';
import 'package:final_project/utils/global_variables.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DailyNutrients {
  API api = API();

  Future<dynamic> fetchDailyNutrients() async {
    try {
      Response response =
          await api.sendRequest.get('/api/everydays/home/$userId');
      return response.data;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<dynamic> postNutrients(int stepCountData) async {
    FormData value = FormData.fromMap({
      "steps": stepCountData,
    });
    try {
      Response response = await api.sendRequest.post(
        '/api/everydays/$userId',
        data: value,
      );
      response.statusCode == 200
          ? Fluttertoast.showToast(msg: response.data['message'])
          : Fluttertoast.showToast(msg: 'error');
      return response.data;
    } catch (e) {
      log(e.toString());
    }
  }
}
