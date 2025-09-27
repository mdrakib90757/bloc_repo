import 'package:dio/dio.dart';
import 'package:serialman_app/data/model/business_type_model/business_type_model.dart';
import 'package:serialman_app/data/provider/auth_api.dart';
import 'package:serialman_app/data/repository/auth_repository.dart'
    hide BusinessType;
import 'package:serialman_app/feature/auth/data/model/registraotion_reqeust.dart';
import 'package:serialman_app/feature/auth/data/model/serviceTaker_register.dart';
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

  Future<void> registerServiceTaker(ServiceTakerRequest request) async {
    try {
      final response = await authApi.registerServiceTaker(request);
      if (response.statusCode != 200) {
        throw Exception("Failed to register Taker center");
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

  Future<List<BusinessType>> fetchBusinessTypes() async {
    try {
      final businessTypes = await authApi.fetchBusinessTypes();
      return businessTypes;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
