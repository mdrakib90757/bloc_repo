import 'package:dio/dio.dart';
import 'package:serialman_app/data/provider/auth_api.dart';
import 'package:serialman_app/data/repository/auth_repository.dart';
import 'package:serialman_app/feature/auth/data/model/registraotion_reqeust.dart';
import '../model/login_request.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi authApi;
  AuthRepositoryImpl(this.authApi);

  Future<void> registerServiceCenter(RegistrationRequest request) async {
    try {
      final response = await authApi.registerServiceCenter(request);
      if (response.statusCode != 200) {
        throw Exception("Failed to register service center");
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? "Unknow error");
    }
  }


  Future<void> Login(LoginRequest request) async {
    try {
      final response = await authApi.login(request);
      if (response.statusCode != 200) {
        throw Exception("Failed to Login");
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? "Unknow error");
    }
  }
}
