import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:final_project/controller/apis/api.dart';

class AddFoodRepository {
  API api = API();

  Future<dynamic> addFood({
    required dynamic userId,
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
          await api.sendRequest.post('$baseUrl/api/everydays', data: value);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> fetchAddedFood() async {
    try {
      Response response = await api.sendRequest.get('$baseUrl/api/everydays/1');
      return response.data;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
