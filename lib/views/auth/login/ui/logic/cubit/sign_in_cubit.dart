// cubit/login_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:mothmerah_app/core/helpers/token_manager.dart';
import 'package:mothmerah_app/views/auth/login/data/login_repository.dart';
import 'package:mothmerah_app/views/auth/login/data/login_request_model.dart';
import 'package:mothmerah_app/views/auth/user_model.dart';

import 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final LoginRepository _repository;

  SignInCubit(this._repository) : super(const SignInState());

  void updatePhoneNumber(String phoneNumber) {
    if (state.phoneNumber != phoneNumber) {
      emit(state.copyWith(phoneNumber: phoneNumber, error: null));
    }
  }

  void updatePassword(String password) {
    if (state.password != password) {
      emit(state.copyWith(password: password, error: null));
    }
  }

  Future<void> login() async {
    if (state.phoneNumber.isEmpty || state.password.isEmpty) {
      emit(
        state.copyWith(error: 'أدخل رقم الجوال وكلمة المرور', isLoading: false),
      );
      return;
    }

    // Validate phone number format (Saudi phone number)
    if (!_isValidSaudiPhoneNumber(state.phoneNumber)) {
      emit(
        state.copyWith(
          error: 'رقم الجوال غير صالح. يجب أن يبدأ بـ +966',
          isLoading: false,
        ),
      );
      return;
    }

    // Additional validation
    if (state.phoneNumber.trim().isEmpty) {
      emit(state.copyWith(error: 'رقم الجوال فارغ', isLoading: false));
      return;
    }

    if (state.password.trim().isEmpty) {
      emit(state.copyWith(error: 'كلمة المرور فارغة', isLoading: false));
      return;
    }

    emit(state.copyWith(isLoading: true, error: null));

    try {
      final request = LoginRequestModel(
        phoneNumber: state.phoneNumber, // رقم الجوال
        password: state.password,
      );

      final response = await _repository.login(request);

      final userDataMap = {
        'user_id': '1',
        'first_name': 'المستخدم',
        'last_name': '',
        'phone_number': state.phoneNumber,
        'email': '',
        'profile_picture_url': null,
        'user_verification_status_id': 1, // محقق
        'is_deleted': false,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
        'updated_by_user_id': '1',
        'additional_data': {},
        'account_status': {
          'status_name_key': 'active',
          'is_terminal': false,
          'account_status_id': 1,
          'translations': [],
        },
        'user_type': {
          'user_type_name_key': 'regular',
          'user_type_id': 1,
          'translations': [],
        },
        'default_role': {
          'role_name_key': 'user',
          'is_active': true,
          'role_id': 1,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
          'translations': [],
        },
        'user_verification_status': {
          'status_name_key': 'verified',
          'description_key': 'user_verified',
          'user_verification_status_id': 1,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
          'translations': [],
        },
        'preferred_language': {
          'language_code': 'ar',
          'language_name_native': 'العربية',
          'language_name_en': 'Arabic',
          'text_direction': 'rtl',
          'is_active_for_interface': true,
          'sort_order': 1,
          'created_at': DateTime.now().toIso8601String(),
        },
      };

      await TokenManager.saveUserData(
        token: response.accessToken,
        userData: userDataMap,
        expiryDate: DateTime.now().add(Duration(days: 30)), // 30 days expiry
      );

      // Create user model for state
      final user = UserModel('1', 'المستخدم', state.phoneNumber);

      emit(state.copyWith(isLoading: false, user: user, error: null));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  bool _isValidSaudiPhoneNumber(String phoneNumber) {
    // Check if phone number starts with +966 and has correct length
    final phoneRegex = RegExp(r'^\+966[0-9]{9}$');
    return phoneRegex.hasMatch(phoneNumber);
  }

  Future<void> logout() async {
    await TokenManager.clearUserData();
    emit(const SignInState());
  }

  void clearError() {
    if (state.error != null) {
      emit(state.copyWith(error: null));
    }
  }
}
