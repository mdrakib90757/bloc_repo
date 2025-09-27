import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:serialman_app/core/network/dio_client.dart';
import 'package:serialman_app/data/model/business_type_model/business_type_model.dart';
import 'package:serialman_app/feature/auth/data/model/registraotion_reqeust.dart';
import 'package:serialman_app/feature/auth/data/model/serviceTaker_register.dart';
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

  Future<Response> registerServiceTaker(ServiceTakerRequest request) async {
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

  Future<List<BusinessType>> fetchBusinessTypes() async {
    try {
      final response = await _dioClient.dio.get(
        "/business-types",
        options: Options(headers: await _dioClient.getHeaders()),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((e) => BusinessType.fromJson(e)).toList();
      } else {
        throw Exception(
          "Failed to fetch business types: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Failed to fetch business types: $e");
    }
  }
}
