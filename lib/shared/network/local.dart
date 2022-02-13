import 'package:dio/dio.dart';

class Diohleper {
  static late Dio dio = Dio();
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getdate({
    required String url,
    Map<String, dynamic>? quary,
    Map<String, dynamic>? data,
    String lang = "en",
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };
    return await dio.get(url, queryParameters: quary);
  }

  static Future<Response> postdata({
    required String url,
    Map<String, dynamic>? quary,
    required Map<String, dynamic> data,
    String lang = "en",
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };
    return await dio.post(url, queryParameters: quary, data: data);
  }

  static Future<Response> putdata({
    required String url,
    Map<String, dynamic>? quary,
    required Map<String, dynamic> data,
    String lang = "en",
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };
    return await dio.put(url, queryParameters: quary, data: data);
  }
}
