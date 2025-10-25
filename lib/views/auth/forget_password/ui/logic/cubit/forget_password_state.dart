abstract class ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordLoading extends ForgetPasswordState {}

class OtpSent extends ForgetPasswordState {
  final String message;
  final String phoneOrEmail;

  OtpSent({required this.message, required this.phoneOrEmail});
}

class OtpVerificationLoading extends ForgetPasswordState {}

class OtpVerified extends ForgetPasswordState {
  final String message;
  final String resetToken;

  OtpVerified({required this.message, required this.resetToken});
}

class PasswordResetLoading extends ForgetPasswordState {}

class PasswordResetSuccess extends ForgetPasswordState {
  final String message;

  PasswordResetSuccess({required this.message});
}

class ForgetPasswordError extends ForgetPasswordState {
  final String error;

  ForgetPasswordError({required this.error});
}

class OtpVerificationError extends ForgetPasswordState {
  final String error;

  OtpVerificationError({required this.error});
}

class PasswordResetError extends ForgetPasswordState {
  final String error;

  PasswordResetError({required this.error});
}
