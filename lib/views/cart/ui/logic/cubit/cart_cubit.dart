import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:mothmerah_app/views/product/data/product_model.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial()) {
    loadCart();
  }

  List<ProductModel> _cartItems = [];

  List<ProductModel> get cartItems => _cartItems;

  double get totalAmount {
    return _cartItems.fold(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );
  }

  int get totalItems {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  Future<void> _saveCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = json.encode(
        _cartItems.map((item) => item.toJson()).toList(),
      );
      await prefs.setString('cart_items', cartJson);
    } catch (e) {
      // Handle error silently
    }
  }

  void loadCart() async {
    emit(CartLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartData = prefs.getString('cart_items');

      if (cartData != null) {
        final List<dynamic> jsonList = json.decode(cartData);
        _cartItems = jsonList
            .map((json) => ProductModel.fromJson(json))
            .toList();
      } else {
        _cartItems = [];
      }

      emit(
        CartLoaded(
          items: _cartItems,
          totalAmount: totalAmount,
          totalItems: totalItems,
        ),
      );
    } catch (e) {
      _cartItems = [];
      emit(
        CartLoaded(
          items: _cartItems,
          totalAmount: totalAmount,
          totalItems: totalItems,
        ),
      );
    }
  }

  void addToCart(ProductModel product, {int quantity = 1}) {
    try {
      // Check if product already exists in cart
      final existingIndex = _cartItems.indexWhere(
        (item) => item.id == product.id,
      );

      if (existingIndex != -1) {
        // Update existing item quantity
        final existingItem = _cartItems[existingIndex];
        final updatedItem = existingItem.copyWith(
          quantity: existingItem.quantity + quantity,
        );
        _cartItems[existingIndex] = updatedItem;

        emit(
          CartItemUpdated(
            productId: product.id,
            quantity: updatedItem.quantity,
          ),
        );
      } else {
        // Add new item to cart
        final cartItem = product.copyWith(quantity: quantity);
        _cartItems.add(cartItem);

        emit(CartItemAdded(product: cartItem, quantity: quantity));
      }

      // Emit updated cart state
      emit(
        CartLoaded(
          items: List.from(_cartItems),
          totalAmount: totalAmount,
          totalItems: totalItems,
        ),
      );

      // Save cart to storage
      _saveCart();
    } catch (e) {
      emit(CartError('خطأ في إضافة المنتج للسلة: ${e.toString()}'));
    }
  }

  void removeFromCart(String productId) {
    try {
      _cartItems.removeWhere((item) => item.id == productId);

      emit(CartItemRemoved(productId));

      // Emit updated cart state
      emit(
        CartLoaded(
          items: List.from(_cartItems),
          totalAmount: totalAmount,
          totalItems: totalItems,
        ),
      );

      // Save cart to storage
      _saveCart();
    } catch (e) {
      emit(CartError('خطأ في حذف المنتج من السلة: ${e.toString()}'));
    }
  }

  void updateQuantity(String productId, int quantity) {
    try {
      if (quantity <= 0) {
        removeFromCart(productId);
        return;
      }

      final index = _cartItems.indexWhere((item) => item.id == productId);
      if (index != -1) {
        _cartItems[index] = _cartItems[index].copyWith(quantity: quantity);

        emit(CartItemUpdated(productId: productId, quantity: quantity));

        // Emit updated cart state
        emit(
          CartLoaded(
            items: List.from(_cartItems),
            totalAmount: totalAmount,
            totalItems: totalItems,
          ),
        );

        // Save cart to storage
        _saveCart();
      }
    } catch (e) {
      emit(CartError('خطأ في تحديث كمية المنتج: ${e.toString()}'));
    }
  }

  void clearCart() {
    try {
      _cartItems.clear();
      emit(CartCleared());

      // Emit updated cart state
      emit(
        CartLoaded(
          items: List.from(_cartItems),
          totalAmount: totalAmount,
          totalItems: totalItems,
        ),
      );

      // Save cart to storage
      _saveCart();
    } catch (e) {
      emit(CartError('خطأ في مسح السلة: ${e.toString()}'));
    }
  }

  bool isInCart(String productId) {
    return _cartItems.any((item) => item.id == productId);
  }

  int getProductQuantity(String productId) {
    final item = _cartItems.firstWhere(
      (item) => item.id == productId,
      orElse: () => ProductModel(
        id: '',
        name: '',
        price: 0.0,
        imageUrl: '',
        category: '',
        weight: '',
        calories: 0,
        quantity: 0,
      ),
    );
    return item.quantity;
  }
}
