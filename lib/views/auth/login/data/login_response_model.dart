class LoginResponseModel {
  final String accessToken;
  final String tokenType;

  LoginResponseModel({required this.accessToken, required this.tokenType});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['access_token'] ?? '',
      tokenType: json['token_type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'access_token': accessToken, 'token_type': tokenType};
  }
}
