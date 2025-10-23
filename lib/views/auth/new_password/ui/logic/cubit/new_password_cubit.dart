import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mothmerah_app/views/auth/new_password/data/new_password_model.dart';
import 'package:mothmerah_app/views/auth/new_password/data/new_password_repository.dart';
import 'package:mothmerah_app/views/auth/new_password/ui/logic/cubit/new_password_state.dart';

class NewPasswordCubit extends Cubit<NewPasswordState> {
  final NewPasswordRepository _repository;
  bool _isPasswordVisible = false;

  NewPasswordCubit(this._repository) : super(NewPasswordInitial());

  bool get isPasswordVisible => _isPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    emit(PasswordVisibilityChanged(_isPasswordVisible));
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    // Validate passwords
    if (currentPassword.isEmpty) {
      emit(NewPasswordError('يرجى إدخال كلمة المرور الحالية'));
      return;
    }

    if (newPassword.isEmpty) {
      emit(NewPasswordError('يرجى إدخال كلمة المرور الجديدة'));
      return;
    }

    if (confirmNewPassword.isEmpty) {
      emit(NewPasswordError('يرجى تأكيد كلمة المرور الجديدة'));
      return;
    }

    if (newPassword != confirmNewPassword) {
      emit(NewPasswordError('كلمة المرور الجديدة وتأكيدها غير متطابقين'));
      return;
    }

    if (newPassword.length < 6) {
      emit(NewPasswordError('كلمة المرور يجب أن تكون 6 أحرف على الأقل'));
      return;
    }

    emit(NewPasswordLoading());

    try {
      final passwordModel = NewPasswordModel(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword,
      );

      await _repository.updatePassword(passwordModel);
      emit(NewPasswordSuccess('تم تحديث كلمة المرور بنجاح'));
    } catch (e) {
      emit(NewPasswordError(e.toString()));
    }
  }
}
