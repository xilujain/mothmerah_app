import 'package:dio/dio.dart';
import 'package:mothmerah_app/views/auth/login/data/login_request_model.dart';
import 'package:mothmerah_app/views/auth/login/data/login_response_model.dart';

class LoginRepository {
  final Dio _dio;

  LoginRepository(this._dio);

  Future<LoginResponseModel> login(LoginRequestModel request) async {
    try {

      // إزالة interceptor للـ debugging (مثل SignUp)

      // التحقق من البيانات قبل الإرسال
      final requestData = request.toJson();

      final response = await _dio.post(
        'http://127.0.0.1:8000/api/v1/auth/login',
        data: requestData,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      // معالجة الاستجابة المباشرة (schemas.Token)
      final tokenModel = LoginResponseModel.fromJson(response.data);

      return tokenModel;
    } on DioException catch (e) {
      final errorData = e.response?.data;

      String errorMessage;
      if (errorData is Map<String, dynamic>) {
        // معالجة أخطاء FastAPI
        if (errorData.containsKey('detail')) {
          if (errorData['detail'] is String) {
            errorMessage = errorData['detail'];
          } else if (errorData['detail'] is List) {
            // معالجة أخطاء validation
            final details = errorData['detail'] as List;
            errorMessage = details
                .map((e) => e['msg'] ?? e.toString())
                .join(', ');
          } else {
            errorMessage = errorData['detail'].toString();
          }
        } else if (errorData.containsKey('message')) {
          errorMessage = errorData['message'];
        } else if (errorData.containsKey('error')) {
          errorMessage = errorData['error'];
        } else {
          errorMessage = 'فشل تسجيل الدخول';
        }
      } else {
        errorMessage = 'فشل تسجيل الدخول';
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('حدث خطأ غير متوقع: $e');
    }
  }
}
