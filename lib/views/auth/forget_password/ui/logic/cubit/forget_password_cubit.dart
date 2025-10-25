import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mothmerah_app/views/auth/forget_password/data/forget_password_models.dart';
import 'package:mothmerah_app/views/auth/forget_password/data/forget_password_repository.dart';
import 'package:mothmerah_app/views/auth/forget_password/ui/logic/cubit/forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordRepository _repository;
  String? _phoneOrEmail;
  String? _resetToken;

  ForgetPasswordCubit(this._repository) : super(ForgetPasswordInitial());

  String? get phoneOrEmail => _phoneOrEmail;
  String? get resetToken => _resetToken;

  /// Send OTP to phone or email
  Future<void> sendOtp(String phoneOrEmail) async {
    emit(ForgetPasswordLoading());

    try {
      final request = ForgetPasswordRequestModel(phoneOrEmail: phoneOrEmail);
      final response = await _repository.sendOtp(request);

      if (response.success) {
        _phoneOrEmail = phoneOrEmail;
        emit(OtpSent(message: response.message, phoneOrEmail: phoneOrEmail));
      } else {
        emit(ForgetPasswordError(error: response.message));
      }
    } catch (e) {
      emit(ForgetPasswordError(error: e.toString()));
    }
  }

  /// Verify OTP code
  Future<void> verifyOtp(String otp) async {
    if (_phoneOrEmail == null) {
      emit(OtpVerificationError(error: 'لم يتم إرسال رمز التحقق'));
      return;
    }

    emit(OtpVerificationLoading());

    try {
      final request = OtpVerificationRequestModel(
        phoneOrEmail: _phoneOrEmail!,
        otp: otp,
      );
      final response = await _repository.verifyOtp(request);

      if (response.success) {
        _resetToken = response.resetToken;
        emit(
          OtpVerified(
            message: response.message,
            resetToken: response.resetToken ?? '',
          ),
        );
      } else {
        emit(OtpVerificationError(error: response.message));
      }
    } catch (e) {
      emit(OtpVerificationError(error: e.toString()));
    }
  }

  /// Reset password
  Future<void> resetPassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    emit(PasswordResetLoading());

    try {
      final request = ResetPasswordRequestModel(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword,
      );
      final response = await _repository.resetPassword(request);

      if (response.success) {
        emit(PasswordResetSuccess(message: response.message));
      } else {
        emit(PasswordResetError(error: response.message));
      }
    } catch (e) {
      emit(PasswordResetError(error: e.toString()));
    }
  }

  /// Clear error state
  void clearError() {
    if (state is ForgetPasswordError ||
        state is OtpVerificationError ||
        state is PasswordResetError) {
      emit(ForgetPasswordInitial());
    }
  }

  /// Reset to initial state
  void reset() {
    _phoneOrEmail = null;
    _resetToken = null;
    emit(ForgetPasswordInitial());
  }
}
