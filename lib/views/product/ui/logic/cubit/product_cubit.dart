import 'package:bloc/bloc.dart';
import 'package:mothmerah_app/views/product/data/product_repository.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _repository;

  ProductCubit(this._repository) : super(ProductInitial());

  Future<void> loadProducts() async {
    emit(ProductLoading());

    try {
      print('🛍️ تحميل المنتجات...');
      final products = await _repository.getProducts();

      print('✅ تم تحميل ${products.length} منتج بنجاح');

      emit(ProductLoaded(products: products));
    } catch (e) {
      print('❌ خطأ في تحميل المنتجات: $e');
      emit(ProductError(error: e.toString()));
    }
  }

  Future<void> refreshProducts() async {
    if (state is ProductLoaded) {
      final currentProducts = (state as ProductLoaded).products;
      emit(ProductRefreshing(products: currentProducts));
    }

    try {
      print('🔄 تحديث المنتجات...');
      final products = await _repository.getProducts();

      print('✅ تم تحديث ${products.length} منتج بنجاح');

      emit(ProductLoaded(products: products));
    } catch (e) {
      print('❌ خطأ في تحديث المنتجات: $e');
      emit(ProductError(error: e.toString()));
    }
  }

  Future<void> loadProductById(String productId) async {
    try {
      print('🛍️ تحميل منتج محدد: $productId');
      final product = await _repository.getProductById(productId);

      print('✅ تم تحميل المنتج بنجاح: ${product.name}');

      // You can emit a specific state for single product if needed
      // For now, we'll just reload all products
      await loadProducts();
    } catch (e) {
      print('❌ خطأ في تحميل المنتج: $e');
      emit(ProductError(error: e.toString()));
    }
  }

  void clearProducts() {
    emit(ProductInitial());
  }
}
