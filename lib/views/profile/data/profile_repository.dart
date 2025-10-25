import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mothmerah_app/core/helpers/token_manager.dart';
import 'package:mothmerah_app/core/services/auth_service.dart';
import 'package:mothmerah_app/views/profile/data/profile_model.dart';

class ProfileRepository {
  final Dio _dio;

  ProfileRepository(this._dio);

  /// Get user profile
  Future<ProfileModel> getProfile(BuildContext context) async {
    try {
      // Validate token before making API call
      if (!await AuthService.validateTokenBeforeApiCall()) {
        throw Exception('انتهت صلاحية الجلسة، يرجى تسجيل الدخول مرة أخرى');
      }

      final token = await TokenManager.getToken();
      final response = await _dio.get(
        'http://127.0.0.1:8000/api/v1/users/me',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      // Check if response indicates token expiration
      if (response.data is Map<String, dynamic>) {
        final wasExpired = await AuthService.checkApiResponse(
          context,
          response.data,
        );
        if (wasExpired) {
          throw Exception('انتهت صلاحية الجلسة، يرجى تسجيل الدخول مرة أخرى');
        }
      }

      // معالجة الاستجابة - قد تكون البيانات مباشرة أو داخل 'data'
      Map<String, dynamic> userData;
      if (response.data is Map<String, dynamic>) {
        if (response.data.containsKey('data')) {
          userData = response.data['data'];
        } else {
          userData = response.data;
        }
      } else {
        throw Exception('تنسيق البيانات غير صحيح');
      }

      final profile = ProfileModel.fromJson(userData);
      return profile;
    } on DioException catch (e) {
      // Handle authentication errors
      if (await AuthService.handleDioException(context, e)) {
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

  /// Update user profile
  Future<ProfileModel> updateProfile(ProfileModel profile) async {
    try {
      final token = await TokenManager.getToken();
      final response = await _dio.patch(
        '/api/v1/me/profile',
        data: profile.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      final updatedProfile = ProfileModel.fromJson(response.data['data']);

      // Update stored user data
      await TokenManager.updateUserData(updatedProfile.toJson());

      return updatedProfile;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await TokenManager.clearUserData();
        throw Exception('انتهت صلاحية الجلسة، يرجى تسجيل الدخول مرة أخرى');
      } else if (e.response != null) {
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

  /// Upload profile image
  Future<String> uploadProfileImage(String imagePath) async {
    try {
      final token = await TokenManager.getToken();
      final formData = FormData.fromMap({
        'profile_image': await MultipartFile.fromFile(imagePath),
      });

      final response = await _dio.post(
        '/api/v1/me/profile/image',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      return response.data['data']['image_url'];
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await TokenManager.clearUserData();
        throw Exception('انتهت صلاحية الجلسة، يرجى تسجيل الدخول مرة أخرى');
      } else if (e.response != null) {
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

  /// Delete account
  Future<void> deleteAccount() async {
    try {
      final token = await TokenManager.getToken();
      await _dio.delete(
        '/api/v1/me/account',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      // Clear user data after successful deletion
      await TokenManager.clearUserData();
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await TokenManager.clearUserData();
        throw Exception('انتهت صلاحية الجلسة، يرجى تسجيل الدخول مرة أخرى');
      } else if (e.response != null) {
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
