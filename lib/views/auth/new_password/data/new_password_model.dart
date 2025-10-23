class NewPasswordModel {
  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;

  NewPasswordModel({
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

  factory NewPasswordModel.fromJson(Map<String, dynamic> json) {
    return NewPasswordModel(
      currentPassword: json['current_password'] ?? '',
      newPassword: json['new_password'] ?? '',
      confirmNewPassword: json['confirm_new_password'] ?? '',
    );
  }
}
