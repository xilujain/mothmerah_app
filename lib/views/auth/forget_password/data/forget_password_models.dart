class ForgetPasswordRequestModel {
  final String phoneOrEmail;

  ForgetPasswordRequestModel({required this.phoneOrEmail});

  Map<String, dynamic> toJson() {
    return {'phone_or_email': phoneOrEmail};
  }
}

class OtpVerificationRequestModel {
  final String phoneOrEmail;
  final String otp;

  OtpVerificationRequestModel({required this.phoneOrEmail, required this.otp});

  Map<String, dynamic> toJson() {
    return {'phone_or_email': phoneOrEmail, 'otp': otp};
  }
}

class ResetPasswordRequestModel {
  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;

  ResetPasswordRequestModel({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'current_password': currentPassword,
      'new_password': newPassword,
      'confirm_new_password': confirmNewPassword,
    };
  }
}

class ForgetPasswordResponseModel {
  final String message;
  final bool success;

  ForgetPasswordResponseModel({required this.message, required this.success});

  factory ForgetPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordResponseModel(
      message: json['message'] ?? '',
      success: json['success'] ?? false,
    );
  }
}

class OtpVerificationResponseModel {
  final String message;
  final bool success;
  final String? resetToken;

  OtpVerificationResponseModel({
    required this.message,
    required this.success,
    this.resetToken,
  });

  factory OtpVerificationResponseModel.fromJson(Map<String, dynamic> json) {
    return OtpVerificationResponseModel(
      message: json['message'] ?? '',
      success: json['success'] ?? false,
      resetToken: json['reset_token'],
    );
  }
}

class ResetPasswordResponseModel {
  final String message;
  final bool success;

  ResetPasswordResponseModel({required this.message, required this.success});

  factory ResetPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponseModel(
      message: json['message'] ?? '',
      success: json['success'] ?? false,
    );
  }
}
