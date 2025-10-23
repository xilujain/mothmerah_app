abstract class NewPasswordState {}

class NewPasswordInitial extends NewPasswordState {}

class NewPasswordLoading extends NewPasswordState {}

class NewPasswordSuccess extends NewPasswordState {
  final String message;

  NewPasswordSuccess(this.message);
}

class NewPasswordError extends NewPasswordState {
  final String error;

  NewPasswordError(this.error);
}

class PasswordVisibilityChanged extends NewPasswordState {
  final bool isVisible;

  PasswordVisibilityChanged(this.isVisible);
}
