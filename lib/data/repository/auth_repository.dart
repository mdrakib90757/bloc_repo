import 'package:serialman_app/feature/auth/data/model/login_request.dart';

import '../../feature/auth/data/model/registraotion_reqeust.dart';

abstract class AuthRepository {
  Future<void> registerServiceCenter(RegistrationRequest request);
}

abstract class AuthLogin {
  Future<void> Login(LoginRequest request);
}
