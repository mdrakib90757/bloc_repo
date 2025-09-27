import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  final Dio dio;
  //DioClient._internal(this.dio);

  DioClient._internal(this.dio) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          print("REQUEST → ${options.method} ${options.uri}");
          return handler.next(options); // continue
        },
        onResponse: (response, handler) {
          print(
            "RESPONSE ← ${response.requestOptions.uri} ${response.statusCode}",
          );
          return handler.next(response); // continue
        },
        onError: (DioError e, handler) {
          print(
            "ERROR ← ${e.requestOptions.uri} ${e.response?.statusCode} ${e.message}",
          );
          return handler.next(e); // continue
        },
      ),
    );
  }

  factory DioClient() {
    final dio = Dio(
      BaseOptions(
        baseUrl: "https://serialno-api.somee.com/api/",
        connectTimeout: const Duration(seconds: 55),
        receiveTimeout: const Duration(seconds: 55),
      ),
    );
    return DioClient._internal(dio);
  }

  Future<Map<String, String>> getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("accessToken");

    print("Saved token: $accessToken");

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    print("Authorization header: ${headers['Authorization']}");
    print("Request headers: $headers");
    return headers;
  }
}
