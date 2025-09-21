import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  final Dio dio;
  DioClient._internal(this.dio);
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

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (accessToken != null) {
      headers["Authorization"] = 'Bearer $accessToken';
    }
    return headers;
  }
}
