import 'package:bloc/bloc.dart';
import 'package:mothmerah_app/views/order/data/order_repository.dart';
import 'package:mothmerah_app/views/order/data/order_request_model.dart';
import 'package:mothmerah_app/views/order/data/order_item_model.dart';
import 'package:mothmerah_app/views/product/data/product_model.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository _repository;

  OrderCubit(this._repository) : super(OrderInitial());

  Future<void> createOrder({
    required List<ProductModel> cartItems,
    required double totalAmount,
    String notesFromBuyer = '',
    String currencyCode = 'SAR',
  }) async {
    emit(OrderLoading());

    try {
      // Calculate amounts
      final discountAmount = 0.0; // No discount for now
      final vatAmount = totalAmount * 0.15; // 15% VAT
      final finalTotalAmount = totalAmount + vatAmount;

      // Convert cart items to order items
      final orderItems = cartItems.map((product) {
        return OrderItemModel(
          productPackagingOptionId: 1, // Default packaging option
          sellerUserId: '2', // Default seller ID
          quantityOrdered: product.quantity,
          unitPriceAtPurchase: product.price,
          totalPriceForItem: product.price * product.quantity,
          itemStatusId: 1, // Pending status
          notes: product.name,
        );
      }).toList();

      // Create order request
      final orderRequest = OrderRequestModel(
        sellerUserId: '2', // Default seller ID
        shippingAddressId: 0, // Default address
        billingAddressId: 0, // Default address
        paymentStatusId: 1, // Pending payment
        sourceOfOrder: 'mobile_app',
        relatedQuoteId: 0,
        relatedAuctionSettlementId: 0,
        notesFromBuyer: notesFromBuyer,
        notesFromSeller: '',
        totalAmountBeforeDiscount: totalAmount,
        discountAmount: discountAmount,
        totalAmountAfterDiscount: totalAmount - discountAmount,
        vatAmount: vatAmount,
        finalTotalAmount: finalTotalAmount,
        currencyCode: currencyCode,
        items: orderItems,
      );

      // Submit order
      final response = await _repository.createOrder(orderRequest);

      emit(OrderSuccess(orderResponse: response));

      // Also emit OrderSubmitted for UI feedback
      emit(
        OrderSubmitted(
          orderId: response.orderId,
          totalAmount: response.totalAmount,
          currencyCode: response.currencyCode,
        ),
      );
    } catch (e) {
      emit(OrderError(error: e.toString()));
    }
  }

  void resetOrder() {
    emit(OrderInitial());
  }
}
