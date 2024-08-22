import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:final_project/controller/apis/api.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/global_variables.dart';

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
    // XFile? image,
  }) async {
    // String fileName = image!.path.split('/').last;
    FormData value = FormData.fromMap({
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
      // "photo": await MultipartFile.fromFile(image.path, filename: fileName),
    });

    try {
      Response response = await api.sendRequest.post(
        '/api/update',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "multipart/form-data",
          },
        ),
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

  Future<dynamic> updateUserPhoto({
    XFile? image,
  }) async {
    String fileName = image!.path.split('/').last;
    FormData value = FormData.fromMap({
      "photo": await MultipartFile.fromFile(image.path, filename: fileName),
    });

    try {
      Response response = await api.sendRequest.post(
        '/api/update',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "multipart/form-data",
          },
        ),
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

  Future<dynamic> goPremium() async {
    FormData value = FormData.fromMap({
      "isPremium": 1,
    });

    try {
      Response response = await api.sendRequest.post(
        '/api/update',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "multipart/form-data",
          },
        ),
        data: value,
      );
      response.data['message'] == 'User updated successfully'
          ? {
              Fluttertoast.showToast(
                  msg: 'You Are now a premium Member',
                  backgroundColor: Colors.green),
              isPremium = 1,
            }
          : Fluttertoast.showToast(
              msg: 'Something Went Wrong Please try Again',
              backgroundColor: Colors.red,
            );
      return response.data;
    } catch (e) {
      // Handle other types of errors
      log('Unexpected error: $e');
      rethrow;
    }
  }
}
