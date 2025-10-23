// sign_up_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mothmerah_app/views/auth/sign_up/data/sign_up_model.dart';
import 'package:mothmerah_app/views/auth/sign_up/data/signup_repository.dart';
import 'package:mothmerah_app/views/auth/sign_up/ui/logic/cubit/sign_up_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _authRepository;

  SignupCubit(this._authRepository) : super(const SignupState());

  void updateName(String name) => emit(state.copyWith(name: name, error: null));
  void updateEmail(String email) =>
      emit(state.copyWith(email: email, error: null));
  void updatePassword(String password) =>
      emit(state.copyWith(password: password, error: null));
  void updateConfirmPassword(String confirmPassword) =>
      emit(state.copyWith(confirmPassword: confirmPassword, error: null));
  void updatePhoneNumber(String phoneNumber) =>
      emit(state.copyWith(phoneNumber: phoneNumber, error: null));
  void toggleTerms(bool accepted) =>
      emit(state.copyWith(acceptedTerms: accepted, error: null));
  void clearError() => emit(state.copyWith(error: null));
  void reset() => emit(const SignupState());

  Future<void> signup() async {
    if (state.name.isEmpty ||
        state.email.isEmpty ||
        state.password.isEmpty ||
        state.confirmPassword.isEmpty) {
      emit(state.copyWith(error: 'الرجاء تعبئة جميع الحقول'));
      return;
    }

    if (!state.email.contains('@')) {
      emit(state.copyWith(error: 'البريد الالكتروني غير صالح'));
      return;
    }

    if (state.password.length < 8) {
      emit(
        state.copyWith(
          error: 'كلمة المرور يجب أن تكون على الأقل مكونة من ٨ أحرف',
        ),
      );
      return;
    }

    if (state.password != state.confirmPassword) {
      emit(state.copyWith(error: 'كلمتا المرور غير متطابقتين'));
      return;
    }

    if (!state.acceptedTerms) {
      emit(state.copyWith(error: 'يرجى قبول الشروط والأحكام'));
      return;
    }

    emit(state.copyWith(isLoading: true, error: null));

    final nameParts = state.name.trim().split(' ');
    final firstName = nameParts.isNotEmpty ? nameParts.first : '';
    final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    // In your signup() method in SignupCubit
    final signupModel = SignupModel.fromSignupData(
      phoneNumber: state.phoneNumber,
      email: state.email,
      firstName: firstName,
      lastName: lastName,
      password: state.password,
    );

    try {
      final user = await _authRepository.signup(signupModel);
      emit(state.copyWith(isLoading: false, user: user));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
