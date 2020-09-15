import 'package:chat_app/common/network/app_header.dart';
import 'package:chat_app/common/network/http.dart';
import 'package:dio/dio.dart';

class Client {
  AppHeader header;

  set setHeader(AppHeader header) {
    this.header = header;
  }

  // ignore: lines_longer_than_80_chars
  Future<Response<dynamic>> get(String endPoint,
      {Map<String, dynamic> queryParams}) async {
    return dio.get(
      endPoint,
      queryParameters: queryParams,
      options: Options(
        headers: header?.toJson(),
      ),
    );
  }

  Future<Response<dynamic>> post(String endPoint, {dynamic body}) async {
    return dio.post(
      endPoint,
      data: body,
      options: Options(
        headers: header?.toJson(),
      ),
    );
  }

  Future<Response<dynamic>> put(String endPoint, {dynamic body}) async {
    return dio.put(
      endPoint,
      data: body,
      options: Options(
        headers: header?.toJson(),
      ),
    );
  }

  // ignore: lines_longer_than_80_chars
  Future<Response<dynamic>> delete(String endPoint,
      {Map<String, dynamic> queryParams}) async {
    return dio.delete(
      endPoint,
      queryParameters: queryParams,
      options: Options(
        headers: header?.toJson(),
      ),
    );
  }
}
