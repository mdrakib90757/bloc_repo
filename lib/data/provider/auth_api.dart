import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:serialman_app/core/network/dio_client.dart';
import 'package:serialman_app/feature/auth/data/model/registraotion_reqeust.dart';
import '../../feature/auth/data/model/login_request.dart';

class AuthApi {
  final DioClient _dioClient = DioClient();

  Future<Response> registerServiceCenter(RegistrationRequest request) async {
    final String body = jsonEncode(request.toJson());
    return _dioClient.dio.post(
      "/serial-no/register-service-center",
      data: body,
      options: Options(headers: await _dioClient.getHeaders()),
    );
  }

  Future<Response> login(LoginRequest request) async {
    final String body = jsonEncode(request.toJson());
    return _dioClient.dio.post(
      "auth/login",
      data: body,
      options: Options(headers: await _dioClient.getHeaders()),
    );
  }
}
