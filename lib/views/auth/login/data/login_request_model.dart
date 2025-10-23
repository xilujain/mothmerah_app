class LoginRequestModel {
  final String phoneNumber; // رقم الجوال
  final String password;

  LoginRequestModel({required this.phoneNumber, required this.password});

  Map<String, dynamic> toJson() {
    return {'phone_number': phoneNumber, 'password': password};
  }
}
