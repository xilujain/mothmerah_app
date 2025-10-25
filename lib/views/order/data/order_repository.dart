import 'package:dio/dio.dart';
import 'package:mothmerah_app/core/helpers/token_manager.dart';
import 'order_request_model.dart';
import 'order_response_model.dart';

class OrderRepository {
  final Dio _dio;

  OrderRepository(this._dio);

  Future<OrderResponseModel> createOrder(OrderRequestModel request) async {
    try {
      // Get token from storage
      final token = await TokenManager.getToken();

      if (token.isEmpty) {
        throw Exception('لم يتم العثور على رمز المصادقة');
      }

      final response = await _dio.post(
        'http://127.0.0.1:8000/api/v1/orders',
        data: request.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return OrderResponseModel.fromJson(response.data);
      } else {
        throw Exception('فشل في إنشاء الطلب: ${response.statusCode}');
      }
    } on DioException catch (e) {
      String errorMessage = 'فشل في إنشاء الطلب';

      if (e.response?.data != null) {
        final errorData = e.response!.data;
        if (errorData is Map<String, dynamic>) {
          errorMessage =
              errorData['detail'] ??
              errorData['message'] ??
              errorData['error'] ??
              errorMessage;
        }
      }

      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('حدث خطأ غير متوقع: $e');
    }
  }
}
