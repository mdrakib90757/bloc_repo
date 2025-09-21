import 'package:serialman_app/feature/auth/data/model/login_request.dart';
import 'package:serialman_app/feature/auth/data/model/registraotion_reqeust.dart';

abstract class AuthEvent {}

class RegistrationServiceCenterEvent extends AuthEvent {
  final RegistrationRequest request;
  RegistrationServiceCenterEvent(this.request);
}

class LoginEvent extends AuthEvent {
  final LoginRequest request;
  LoginEvent(this.request);
}
