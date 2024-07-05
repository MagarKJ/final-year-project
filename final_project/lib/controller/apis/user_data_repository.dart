import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:final_project/controller/apis/api.dart';

class GetUserData {
  API api = API();

  Future<dynamic> getUserData({
    required dynamic token,
  }) async {
    try {
      log('api/me');
      Response response = await api.sendRequest.post('/api/me',
          options: Options(headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          }));

      return response.data;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
