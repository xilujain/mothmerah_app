import 'package:dio/dio.dart';
import 'package:mothmerah_app/views/auth/new_password/data/new_password_model.dart';

class NewPasswordRepository {
  final Dio _dio;

  NewPasswordRepository(this._dio);

  Future<Map<String, dynamic>> updatePassword(
    NewPasswordModel passwordModel,
  ) async {
    try {
      final response = await _dio.patch(
        'http://127.0.0.1:8000/api/v1/me/password',
        data: passwordModel.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            // Add authorization header if needed
            // 'Authorization': 'Bearer $token',
          },
        ),
      );

      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
          'خطأ في الخادم: ${e.response?.data['message'] ?? 'حدث خطأ غير متوقع'}',
        );
      } else {
        throw Exception('خطأ في الاتصال: ${e.message}');
      }
    } catch (e) {
      throw Exception('حدث خطأ غير متوقع: $e');
    }
  }
}
