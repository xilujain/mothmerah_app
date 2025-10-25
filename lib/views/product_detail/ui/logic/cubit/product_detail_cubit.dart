import 'package:bloc/bloc.dart';
import 'package:mothmerah_app/views/product/data/product_model.dart';
import 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit() : super(ProductDetailInitial());

  void loadProduct(ProductModel product) {
    emit(
      ProductDetailLoaded(product: product, currentImageIndex: 0, quantity: 1),
    );
  }

  void changeImage(int index) {
    if (state is ProductDetailLoaded) {
      final currentState = state as ProductDetailLoaded;
      emit(
        ProductDetailLoaded(
          product: currentState.product,
          currentImageIndex: index,
          quantity: currentState.quantity,
        ),
      );
    }
  }

  void updateQuantity(int quantity) {
    if (state is ProductDetailLoaded) {
      final currentState = state as ProductDetailLoaded;
      if (quantity > 0) {
        emit(
          ProductDetailLoaded(
            product: currentState.product,
            currentImageIndex: currentState.currentImageIndex,
            quantity: quantity,
          ),
        );
      }
    }
  }

  void incrementQuantity() {
    if (state is ProductDetailLoaded) {
      final currentState = state as ProductDetailLoaded;
      updateQuantity(currentState.quantity + 1);
    }
  }

  void decrementQuantity() {
    if (state is ProductDetailLoaded) {
      final currentState = state as ProductDetailLoaded;
      if (currentState.quantity > 1) {
        updateQuantity(currentState.quantity - 1);
      }
    }
  }
}
