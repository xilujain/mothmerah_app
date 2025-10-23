class UserModel {
  final String? name;
  final String? email;
  final String? password;

  const UserModel(this.name, this.email, this.password);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      json['name'] as String?,
      json['email'] as String?,
      json['password'] as String?,
    );
  }
}