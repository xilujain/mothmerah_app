// cubit/signup_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:mothmerah_app/views/auth/login/data/sign_in_model.dart';
import 'package:mothmerah_app/views/auth/sign_up/ui/logic/cubit/sign_up_state.dart';


class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(const SignupState());

  // Store registered users (in real app, this would be an API/database)
  final Map<String, dynamic> _registeredUsers = {
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

  void updateName(String name) {
    if (state.name != name) {
      emit(state.copyWith(name: name, error: null));
    }
  }

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

  void updateConfirmPassword(String confirmPassword) {
    if (state.confirmPassword != confirmPassword) {
      emit(state.copyWith(confirmPassword: confirmPassword, error: null));
    }
  }

  Future<void> signup() async {
    // Validate inputs
    if (state.name.isEmpty || 
        state.email.isEmpty || 
        state.password.isEmpty || 
        state.confirmPassword.isEmpty) {
      emit(state.copyWith(
        error: 'الرجاء تعبئة جميع الحقول',
        isLoading: false,
      ));
      return;
    }

    if (!state.email.contains('@')) {
      emit(state.copyWith(
        error: 'البريد الإلكتروني غير صالح',
        isLoading: false,
      ));
      return;
    }

    if (state.password.length < 8) {
      emit(state.copyWith(
        error: 'كلمة المرور التي أدخلتها أقل من 8 أحرف',
        isLoading: false,
      ));
      return;
    }

    if (state.password != state.confirmPassword) {
      emit(state.copyWith(
        error: 'كلمتا المرور غير متطابقتان',
        isLoading: false,
      ));
      return;
    }

    // Check if user already exists
    if (_registeredUsers.containsKey(state.email)) {
      emit(state.copyWith(
        error: 'الحساب موجود بالفعل',
        isLoading: false,
      ));
      return;
    }

    emit(state.copyWith(isLoading: true, error: null));

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    // Create new user
    final newUser = UserModel(
      id: '${_registeredUsers.length + 1}',
      name: state.name,
      email: state.email,
      token: 'dummy_token_${DateTime.now().millisecondsSinceEpoch}',
    );

    // Register new user
    _registeredUsers[state.email] = {
      'password': state.password,
      'user': newUser,
    };

    // Signup successful
    emit(state.copyWith(
      isLoading: false,
      user: newUser,
      error: null,
    ));
  }

  void clearError() {
    if (state.error != null) {
      emit(state.copyWith(error: null));
    }
  }

  void reset() {
    emit(const SignupState());
  }
}