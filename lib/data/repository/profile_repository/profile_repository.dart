import 'package:serialman_app/data/model/profile_modle/profile_modle.dart';

abstract class ProfileRepository {
  Future<profile_UserModel> fetchProfileData();
}
