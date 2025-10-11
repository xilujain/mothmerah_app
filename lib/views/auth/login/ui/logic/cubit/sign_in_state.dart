import 'package:mothmerah_app/views/auth/login/data/sign_in_model.dart';

class SignInState {
  final String email;
  final String password;
  final bool isLoading;
  final String? error;
  final UserModel? user;

  const SignInState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.error,
    this.user,
  });

  SignInState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    String? error,
    UserModel? user,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }

  // Manual equality check
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is SignInState &&
        other.email == email &&
        other.password == password &&
        other.isLoading == isLoading &&
        other.error == error &&
        other.user == user;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        password.hashCode ^
        isLoading.hashCode ^
        error.hashCode ^
        user.hashCode;
  }

  @override
  String toString() {
    return 'SignInState(email: $email, password: $password, isLoading: $isLoading, error: $error, user: $user)';
  }
}