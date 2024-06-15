import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:final_project/controller/apis/api.dart';

class AllProductRepository {
  API api = API();

  Future<dynamic> fetchAllProduct() async {
    try {
      // Use the correct IP for your local server
      Response response =
          await api.sendRequest.get('http://192.168.254.90:8000/api/meals');
      // log('Response status: ${response.statusCode}');
      // log('Response data: ${response.data}');

      // Check if the response status is OK
      if (response.statusCode == 200) {
        var val = response.data; // Do not use jsonDecode here
        log('Decoded response: $val');
        return val;
      } else {
        throw Exception(
            'Failed to load products. Status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error occurred: $e');
      rethrow;
    }
  }
}
