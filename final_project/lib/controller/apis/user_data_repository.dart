import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:final_project/controller/apis/api.dart';

import '../../model/global_variables.dart';

class ApiResponse {
  final int statusCode;
  final dynamic data;

  ApiResponse({
    required this.statusCode,
    required this.data,
  });
}

class GetUserData {
  API api = API();

  Future<dynamic> getUserData({
    required dynamic token,
  }) async {
    try {
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

  Future<dynamic> updateUserData({
    dynamic name,
    dynamic age,
    dynamic phoneno,
    dynamic email,
    dynamic sex,
    dynamic weight,
    dynamic ethnicity,
    dynamic bodytype,
    dynamic bodygoal,
    dynamic bloodPressue,
    dynamic bloodSugar,
    dynamic image,
  }) async {
    var value = {
      "email": email,
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
      "photo": image
    };

    try {
      Response response = await api.sendRequest.post(
        '/api/update',
        options: Options(headers: {"Authorization": "Bearer $token"}),
        data: value,
      );

      return ApiResponse(
        statusCode: response.statusCode!,
        data: response.data,
      );
    } on DioError catch (dioError) {
      // Handle Dio specific errors
      log('Dio error: ${dioError.message}');
      if (dioError.response != null) {
        log('Dio response data: ${dioError.response?.data}');
        log('Dio response status code: ${dioError.response?.statusCode}');
      }
      rethrow;
    } catch (e) {
      // Handle other types of errors
      log('Unexpected error: $e');
      rethrow;
    }
  }
}
