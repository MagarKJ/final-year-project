import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:final_project/controller/apis/api.dart';
import 'package:final_project/model/global_variables.dart';

class AnalyticsRepository {
  API api = API();

  Future<dynamic> fetchAnalytics() async {
    try {
      Response response = await api.sendRequest.get('/api/analytics/$userId');
      return response.data;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
