import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:final_project/controller/apis/api.dart';
import 'package:final_project/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddFoodRepository {
  API api = API();

  Future<dynamic> addFood({
    required dynamic foodName,
    required dynamic foodDescription,
    required dynamic foodCalories,
    required dynamic foodCarbs,
    required dynamic foodProtein,
    required dynamic foodFat,
    required dynamic foodSodium,
    required dynamic image,
  }) async {
    var value = {
      "user_id": userId,
      "name": foodName,
      "description": foodDescription,
      "calories": foodCalories,
      "carbohydrate": foodCarbs,
      "protein": foodProtein,
      "fat": foodFat,
      "sodium": foodSodium,
      "photo_name": image,
    };

    try {
      Response response =
          await api.sendRequest.post('/api/everydays', data: value);

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> addPremiumFood({
    required dynamic foodName,
    required dynamic description,
    required dynamic foodCalories,
    required dynamic foodCarbs,
    required dynamic foodProtein,
    required dynamic foodFat,
    required dynamic foodSodium,
    required dynamic volume,
    required dynamic image,
    required dynamic quality,
    required dynamic type,
  }) async {
    String fileName = image!.path.split('/').last;
    FormData value = FormData.fromMap({
      "user_id": userId,
      "name": foodName,
      "description": description,
      "calories": foodCalories,
      "carbohydrate": foodCarbs,
      "protein": foodProtein,
      "fat": foodFat,
      "sodium": foodSodium,
      "volume": volume,
      "drink": type,
      "quantity": quality,
      "photo": await MultipartFile.fromFile(image.path, filename: fileName),
    });

    try {
      Response response = await api.sendRequest.post(
        '/api/customs',
        data: value,
      );
      response.data['message'] == 'New Meal Added'
          ? Fluttertoast.showToast(
              msg: 'New Meal Added', backgroundColor: Colors.green)
          : Fluttertoast.showToast(
              msg: 'Error Adding Food', backgroundColor: Colors.red);
      return response.data;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<dynamic> fetchAddedFood() async {
    try {
      Response response = await api.sendRequest.get('/api/everydays/$userId');
      return response.data;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<dynamic> removeSpecificMeal({
    required dynamic foodID,
  }) async {
    try {
      var value = {
        "_method": "DELETE",
      };

      Response response = await api.sendRequest.post(
        '/api/everydays/$foodID',
        data: value,
      );
      return response.data;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<dynamic> removeAllDailyMeals() async {
    try {
      Response response =
          await api.sendRequest.delete('/api/everydays/destroy/$userId');
      log('/api/everydays/destroy/$userId');
      return response.data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> deletePremiumFood({required String foodId}) async {
    try {
      Response response =
          await api.sendRequest.delete('/api/customs/$foodId?_method=DELETE');
      log('delete bhop');
      return response.data;
    } catch (e) {
      log(e.toString());
    }
  }
}
