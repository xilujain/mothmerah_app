// cubit/signup_state.dart
import 'package:mothmerah_app/views/auth/login/data/sign_in_model.dart';

class SignupState {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final bool isLoading;
  final String? error;
  final UserModel? user;

  const SignupState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.isLoading = false,
    this.error,
    this.user,
  });

  SignupState copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    bool? isLoading,
    String? error,
    UserModel? user,
  }) {
    return SignupState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }

  // Manual equality check
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SignupState &&
        other.name == name &&
        other.email == email &&
        other.password == password &&
        other.confirmPassword == confirmPassword &&
        other.isLoading == isLoading &&
        other.error == error &&
        other.user == user;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        confirmPassword.hashCode ^
        isLoading.hashCode ^
        error.hashCode ^
        user.hashCode;
  }

  @override
  String toString() {
    return 'SignupState(name: $name, email: $email, password: $password, confirmPassword: $confirmPassword, isLoading: $isLoading, error: $error, user: $user)';
  }
}
