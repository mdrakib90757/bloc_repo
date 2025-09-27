import 'package:serialman_app/core/network/dio_client.dart';
import 'package:serialman_app/data/model/profile_modle/profile_modle.dart';

class ProfileApi {
  final DioClient _client = DioClient();
  Future<profile_UserModel> fetchProfileData() async {
    final response = await _client.dio.get("/me/v2/profile");
    print(response);
    return profile_UserModel.fromJson(response.data);
  }
}
