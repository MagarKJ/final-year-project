import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:final_project/controller/apis/api.dart';
import 'package:final_project/model/global_variables.dart';

class AddFoodRepository {
  API api = API();

  Future<dynamic> addFood({
    required dynamic foodName,
    required dynamic foodCalories,
    required dynamic foodCarbs,
    required dynamic foodProtein,
    required dynamic foodFat,
    required dynamic foodSodium,
  }) async {
    var value = {
      "user_id": userId,
      "name": foodName,
      "calories": foodCalories,
      "carbohydrate": foodCarbs,
      "protein": foodProtein,
      "fat": foodFat,
      "sodium": foodSodium,
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
  }) async {
    var value = {
      "user_id": userId,
      "name": foodName,
      "description": description,
      "calories": foodCalories,
      "carbohydrate": foodCarbs,
      "protein": foodProtein,
      "fat": foodFat,
      "sodium": foodSodium,
      "volume": volume,
      "photo": image,
    };

    try {
      Response response =
          await api.sendRequest.post('/api/customs', data: value);
      return response.data;
    } catch (e) {
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
