// cubit/login_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:mothmerah_app/views/auth/login/data/sign_in_model.dart';

import 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(const SignInState());

  // Dummy user data
  final Map<String, dynamic> _dummyUsers = {
    'user@example.com': {
      'password': 'password123',
      'user': UserModel(
        id: '1',
        name: 'John Doe',
        email: 'user@example.com',
        token: 'dummy_token_123',
      ),
    },
    'admin@example.com': {
      'password': 'admin123',
      'user': UserModel(
        id: '2',
        name: 'Admin User',
        email: 'admin@example.com',
        token: 'dummy_token_456',
      ),
    },
  };

  void updateEmail(String email) {
    if (state.email != email) {
      emit(state.copyWith(email: email, error: null));
    }
  }

  void updatePassword(String password) {
    if (state.password != password) {
      emit(state.copyWith(password: password, error: null));
    }
  }

  Future<void> login() async {
    if (state.email.isEmpty || state.password.isEmpty) {
      emit(
        state.copyWith(
          error: 'أدخل البريد الالكتروني وكلمة المرور',
          isLoading: false,
        ),
      );
      return;
    }

    if (!state.email.contains('@')) {
      emit(
        state.copyWith(
          error: 'البريد الإلكتروني الذي أدخلت ه غير صالح',
          isLoading: false,
        ),
      );
      return;
    }

    emit(state.copyWith(isLoading: true, error: null));

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    // Check if user exists in dummy data
    if (_dummyUsers.containsKey(state.email)) {
      final userData = _dummyUsers[state.email];

      if (userData['password'] == state.password) {
        // Login successful
        emit(
          state.copyWith(isLoading: false, user: userData['user'], error: null),
        );
      } else {
        // Wrong password
        emit(
          state.copyWith(
            isLoading: false,
            error: 'كلمة المرور التي أدخلتها خاطئة',
          ),
        );
      }
    } else {
      // User not found
      emit(
        state.copyWith(isLoading: false, error: 'الحساب غير موجود في النظام'),
      );
    }
  }

  void logout() {
    emit(const SignInState());
  }

  void clearError() {
    if (state.error != null) {
      emit(state.copyWith(error: null));
    }
  }
}
