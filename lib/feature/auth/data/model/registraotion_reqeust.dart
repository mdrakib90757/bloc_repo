class RegistrationRequest {
  final String name;
  final String addressLine1;
  final String addressLine2;
  final String contactName;
  final String email;
  final String phone;
  final String organizationName;
  final int businessTypeId;
  final String loginName;
  final String password;

  RegistrationRequest({
    required this.name,
    required this.addressLine1,
    required this.addressLine2,
    required this.contactName,
    required this.email,
    required this.phone,
    required this.organizationName,
    required this.businessTypeId,
    required this.loginName,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "addressLine1": addressLine1,
      "addressLine2": addressLine2,
      "contactName": contactName,
      "email": email,
      "phone": phone,
      "organizationName": organizationName,
      "businessTypeId": businessTypeId,
      "loginName": loginName,
      "password": password,
    };
  }
}
