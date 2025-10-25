import 'package:dio/dio.dart';
import 'package:mothmerah_app/core/helpers/token_manager.dart';
import 'package:mothmerah_app/views/auth/forget_password/data/forget_password_models.dart';

class ForgetPasswordRepository {
  final Dio _dio;

  ForgetPasswordRepository(this._dio);

  /// Send OTP to phone or email
  Future<ForgetPasswordResponseModel> sendOtp(
    ForgetPasswordRequestModel request,
  ) async {
    try {
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/v1/auth/forgot-password',
        data: request.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.data is Map<String, dynamic>) {
        return ForgetPasswordResponseModel.fromJson(response.data);
      } else {
        throw Exception('تنسيق البيانات غير صحيح');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final errorData = e.response?.data;
        String errorMessage = 'حدث خطأ غير متوقع';

        if (errorData is Map<String, dynamic>) {
          if (errorData.containsKey('detail')) {
            errorMessage = errorData['detail'].toString();
          } else if (errorData.containsKey('message')) {
            errorMessage = errorData['message'];
          }
        }
        throw Exception('خطأ في الخادم: $errorMessage');
      } else {
        throw Exception('خطأ في الاتصال: ${e.message}');
      }
    } catch (e) {
      throw Exception('حدث خطأ غير متوقع: $e');
    }
  }

  /// Verify OTP code
  Future<OtpVerificationResponseModel> verifyOtp(
    OtpVerificationRequestModel request,
  ) async {
    try {
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/v1/auth/verify-otp',
        data: request.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.data is Map<String, dynamic>) {
        return OtpVerificationResponseModel.fromJson(response.data);
      } else {
        throw Exception('تنسيق البيانات غير صحيح');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final errorData = e.response?.data;
        String errorMessage = 'حدث خطأ غير متوقع';

        if (errorData is Map<String, dynamic>) {
          if (errorData.containsKey('detail')) {
            errorMessage = errorData['detail'].toString();
          } else if (errorData.containsKey('message')) {
            errorMessage = errorData['message'];
          }
        }
        throw Exception('خطأ في الخادم: $errorMessage');
      } else {
        throw Exception('خطأ في الاتصال: ${e.message}');
      }
    } catch (e) {
      throw Exception('حدث خطأ غير متوقع: $e');
    }
  }

  /// Reset password using the provided endpoint
  Future<ResetPasswordResponseModel> resetPassword(
    ResetPasswordRequestModel request,
  ) async {
    try {
      // Get the authentication token
      final token = await TokenManager.getToken();
      if (token.isEmpty) {
        throw Exception('انتهت صلاحية الجلسة، يرجى تسجيل الدخول مرة أخرى');
      }

      final response = await _dio.patch(
        'http://127.0.0.1:8000/api/v1/users/me/password',
        data: request.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.data is Map<String, dynamic>) {
        return ResetPasswordResponseModel.fromJson(response.data);
      } else {
        throw Exception('تنسيق البيانات غير صحيح');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        // Clear user data on unauthorized
        await TokenManager.clearUserData();
        throw Exception('انتهت صلاحية الجلسة، يرجى تسجيل الدخول مرة أخرى');
      }

      if (e.response != null) {
        final errorData = e.response?.data;
        String errorMessage = 'حدث خطأ غير متوقع';

        if (errorData is Map<String, dynamic>) {
          if (errorData.containsKey('detail')) {
            errorMessage = errorData['detail'].toString();
          } else if (errorData.containsKey('message')) {
            errorMessage = errorData['message'];
          }
        }
        throw Exception('خطأ في الخادم: $errorMessage');
      } else {
        throw Exception('خطأ في الاتصال: ${e.message}');
      }
    } catch (e) {
      throw Exception('حدث خطأ غير متوقع: $e');
    }
  }
}
