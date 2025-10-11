import 'package:mothmerah_app/views/auth/login/data/sign_in_model.dart';

class SignupState {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final bool isLoading;
  final String? error;
  final UserModel? user;
  final bool acceptedTerms;

  const SignupState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.isLoading = false,
    this.error,
    this.user,
    this.acceptedTerms = false,
  });

  SignupState copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    bool? isLoading,
    String? error,
    UserModel? user,
    bool? acceptedTerms,
  }) {
    return SignupState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      user: user ?? this.user,
      acceptedTerms: acceptedTerms ?? this.acceptedTerms,
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
        other.user == user &&
        other.acceptedTerms == acceptedTerms;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        confirmPassword.hashCode ^
        isLoading.hashCode ^
        error.hashCode ^
        user.hashCode ^
        acceptedTerms.hashCode;
  }

  @override
  String toString() {
    return 'SignupState(name: $name, email: $email, password: $password, confirmPassword: $confirmPassword, isLoading: $isLoading, error: $error, user: $user, acceptedTerms: $acceptedTerms)';
  }
}