import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class API {
  Dio dio = Dio();

  API() {
    dio.options.baseUrl = baseUrl;
    dio.options.headers['Accept'] = 'application/json';
    dio.interceptors.add(PrettyDioLogger());

    dio.options.connectTimeout = Duration(seconds: 5000); // 5s
  }
  Dio get sendRequest => dio;
}

// String baseUrl = "http://127.0.0.1:8000";
//home ko
// String baseUrl = 'http://192.168.254.186:8000';
//mobile ko
String baseUrl = 'http://192.168.115.28:8000';
//office ko
// String baseUrl = 'http://192.168.1.72:8000';
//yuzan ko ghar
// String baseUrl = 'http://192.168.1.105:8000';
String imageBaseUrl = '$baseUrl/storage';

// String baseUrl = "http://10.0.2.2:8000";
