import 'package:bloc/bloc.dart';
import 'package:mothmerah_app/views/product/data/product_repository.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _repository;

  ProductCubit(this._repository) : super(ProductInitial());

  Future<void> loadProducts() async {
    emit(ProductLoading());

    try {
      final products = await _repository.getProducts();

      emit(ProductLoaded(products: products));
    } catch (e) {
      emit(ProductError(error: e.toString()));
    }
  }

  Future<void> refreshProducts() async {
    if (state is ProductLoaded) {
      final currentProducts = (state as ProductLoaded).products;
      emit(ProductRefreshing(products: currentProducts));
    }

    try {
      final products = await _repository.getProducts();

      emit(ProductLoaded(products: products));
    } catch (e) {
      emit(ProductError(error: e.toString()));
    }
  }

  Future<void> loadProductById(String productId) async {
    try {
      await _repository.getProductById(productId);

      // You can emit a specific state for single product if needed
      // For now, we'll just reload all products
      await loadProducts();
    } catch (e) {
      emit(ProductError(error: e.toString()));
    }
  }

  void clearProducts() {
    emit(ProductInitial());
  }
}
