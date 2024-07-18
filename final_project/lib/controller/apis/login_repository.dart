import 'dart:developer';

import 'package:final_project/controller/apis/api.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginRepository {
  API api = API();

  Future<dynamic> login({
    required dynamic email,
    required dynamic password,
  }) async {
    var value = {
      "email": email,
      "password": password,
    };
    // Map<String, String> headers = {
    //   'Accept': 'application/json',
    // };
    // headers['Accept'] = 'application/json';
    // Options options = Options(headers: headers);
    try {
      log('try');
      var response = await api.sendRequest.post(
        '/api/auth/login',
        data: value,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        String token = data['access_token'];
        // log('Token Type: $token');

        return token;
      } else {
        Fluttertoast.showToast(msg: 'Failed to log in');
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
