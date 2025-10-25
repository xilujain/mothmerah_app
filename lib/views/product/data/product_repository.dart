import 'package:dio/dio.dart';
import 'package:mothmerah_app/core/helpers/token_manager.dart';
import 'api_product_model.dart';

class ProductRepository {
  final Dio _dio;

  ProductRepository(this._dio);

  Future<List<ApiProductModel>> getProducts() async {
    try {
      // Get token from storage
      final token = await TokenManager.getToken();

      if (token.isEmpty) {
        throw Exception('لم يتم العثور على رمز المصادقة');
      }

      print('🛍️ جلب المنتجات من API...');

      final response = await _dio.get(
        'http://localhost:8000/api/v1/products/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      print('✅ تم جلب المنتجات بنجاح');
      print('📊 حالة الاستجابة: ${response.statusCode}');
      print('📦 عدد المنتجات: ${(response.data as List).length}');

      if (response.statusCode == 200) {
        final List<dynamic> productsJson = response.data;
        return productsJson
            .map((json) => ApiProductModel.fromJson(json))
            .toList();
      } else {
        throw Exception('فشل في جلب المنتجات: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ خطأ في جلب المنتجات: ${e.message}');
      print('📊 كود الخطأ: ${e.response?.statusCode}');
      print('📄 تفاصيل الخطأ: ${e.response?.data}');

      String errorMessage = 'فشل في جلب المنتجات';

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
      print('❌ خطأ عام في جلب المنتجات: $e');
      throw Exception('حدث خطأ غير متوقع: $e');
    }
  }

  Future<ApiProductModel> getProductById(String productId) async {
    try {
      // Get token from storage
      final token = await TokenManager.getToken();

      if (token.isEmpty) {
        throw Exception('لم يتم العثور على رمز المصادقة');
      }

      print('🛍️ جلب منتج محدد: $productId');

      final response = await _dio.get(
        'http://localhost:8000/api/v1/products/$productId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      print('✅ تم جلب المنتج بنجاح');
      print('📊 حالة الاستجابة: ${response.statusCode}');

      if (response.statusCode == 200) {
        return ApiProductModel.fromJson(response.data);
      } else {
        throw Exception('فشل في جلب المنتج: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ خطأ في جلب المنتج: ${e.message}');
      print('📊 كود الخطأ: ${e.response?.statusCode}');
      print('📄 تفاصيل الخطأ: ${e.response?.data}');

      String errorMessage = 'فشل في جلب المنتج';

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
      print('❌ خطأ عام في جلب المنتج: $e');
      throw Exception('حدث خطأ غير متوقع: $e');
    }
  }
}
