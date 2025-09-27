import 'package:dio/dio.dart';
import 'package:serialman_app/data/model/profile_modle/profile_modle.dart';
import 'package:serialman_app/data/provider/profile_api/profile_api.dart';
import 'package:serialman_app/data/repository/profile_repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileApi _profileApi;
  ProfileRepositoryImpl(this._profileApi);

  Future<profile_UserModel> fetchProfileData() async {
    try {
      final response = await _profileApi.fetchProfileData();
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? "Unknow error");
    }
  }
}
