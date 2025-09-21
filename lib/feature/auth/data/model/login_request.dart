class LoginRequest {
  final String loginName;
  final String password;

  LoginRequest({required this.loginName, required this.password});

  Map<String, dynamic> toJson() {
    return {"loginName": loginName, "password": password};
  }
}
