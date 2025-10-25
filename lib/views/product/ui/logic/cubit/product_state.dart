import 'package:mothmerah_app/views/product/data/api_product_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ApiProductModel> products;

  ProductLoaded({required this.products});
}

class ProductError extends ProductState {
  final String error;

  ProductError({required this.error});
}

class ProductRefreshing extends ProductState {
  final List<ApiProductModel> products;

  ProductRefreshing({required this.products});
}
