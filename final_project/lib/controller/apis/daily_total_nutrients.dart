import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:final_project/controller/apis/api.dart';
import 'package:final_project/utils/global_variables.dart';

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
}
