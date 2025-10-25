import 'package:mothmerah_app/views/product/data/product_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<ProductModel> items;
  final double totalAmount;
  final int totalItems;

  CartLoaded({
    required this.items,
    required this.totalAmount,
    required this.totalItems,
  });

  CartLoaded copyWith({
    List<ProductModel>? items,
    double? totalAmount,
    int? totalItems,
  }) {
    return CartLoaded(
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      totalItems: totalItems ?? this.totalItems,
    );
  }
}

class CartError extends CartState {
  final String error;

  CartError(this.error);
}

class CartItemAdded extends CartState {
  final ProductModel product;
  final int quantity;

  CartItemAdded({required this.product, required this.quantity});
}

class CartItemRemoved extends CartState {
  final String productId;

  CartItemRemoved(this.productId);
}

class CartItemUpdated extends CartState {
  final String productId;
  final int quantity;

  CartItemUpdated({required this.productId, required this.quantity});
}

class CartCleared extends CartState {}
