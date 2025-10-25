import 'package:mothmerah_app/views/product/data/product_model.dart';

abstract class ProductDetailState {}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLoaded extends ProductDetailState {
  final ProductModel product;
  final int currentImageIndex;
  final int quantity;

  ProductDetailLoaded({
    required this.product,
    this.currentImageIndex = 0,
    this.quantity = 1,
  });
}

class ProductDetailError extends ProductDetailState {
  final String error;

  ProductDetailError({required this.error});
}
