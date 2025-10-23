// data/auth_repository.dart

import 'package:dio/dio.dart';
import 'package:mothmerah_app/views/auth/sign_up/data/sign_up_model.dart';
import 'package:mothmerah_app/views/auth/user_model.dart';

class AuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);

  Future<UserModel> signup(SignupModel signupModel) async {
    try {
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/v1/auth/register',
        data: signupModel.toJson(),
      );

      // Handle different possible response structures
      final data = response.data['data'] ?? response.data;

      // Make sure this matches your actual API response structure
      return UserModel(
        '${data['first_name']} ${data['last_name']}', // or use data['name'] if available
        data['email'] ?? '',
        data['password'] ?? '', // Note: API usually doesn't return password
      );
    } on DioException catch (e) {
      final errorData = e.response?.data;
      final errorMessage =
          errorData?['detail'] ?? errorData?['error'] ?? 'فشل التسجيل';
      throw Exception(errorMessage);
    }
  }
}
