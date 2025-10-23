// sign_up_state.dart

import 'package:mothmerah_app/views/auth/user_model.dart';

class SignupState {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String phoneNumber;
  final bool acceptedTerms;
  final bool isLoading;
  final String? error;
  final UserModel? user;

  const SignupState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.phoneNumber = '',
    this.acceptedTerms = false,
    this.isLoading = false,
    this.error,
    this.user,
  });

  SignupState copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    String? phoneNumber,
    bool? acceptedTerms,
    bool? isLoading,
    String? error,
    UserModel? user,
  }) {
    return SignupState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      acceptedTerms: acceptedTerms ?? this.acceptedTerms,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      user: user ?? this.user,
    );
  }

  List<Object?> get props => [
    name,
    email,
    password,
    confirmPassword,
    phoneNumber,
    acceptedTerms,
    isLoading,
    error,
    user,
  ];
}
