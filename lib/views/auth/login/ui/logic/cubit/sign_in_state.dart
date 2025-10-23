import 'package:mothmerah_app/views/auth/user_model.dart';

class SignInState {
  final String phoneNumber;
  final String password;
  final bool isLoading;
  final String? error;
  final UserModel? user;

  const SignInState({
    this.phoneNumber = '',
    this.password = '',
    this.isLoading = false,
    this.error,
    this.user,
  });

  SignInState copyWith({
    String? phoneNumber,
    String? password,
    bool? isLoading,
    String? error,
    UserModel? user,
  }) {
    return SignInState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
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
        other.phoneNumber == phoneNumber &&
        other.password == password &&
        other.isLoading == isLoading &&
        other.error == error &&
        other.user == user;
  }

  @override
  int get hashCode {
    return phoneNumber.hashCode ^
        password.hashCode ^
        isLoading.hashCode ^
        error.hashCode ^
        user.hashCode;
  }

  @override
  String toString() {
    return 'SignInState(phoneNumber: $phoneNumber, password: $password, isLoading: $isLoading, error: $error, user: $user)';
  }
}
