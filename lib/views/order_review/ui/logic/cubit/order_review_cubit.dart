import 'package:bloc/bloc.dart';
import 'order_review_state.dart';

class OrderReviewCubit extends Cubit<OrderReviewState> {
  OrderReviewCubit() : super(OrderReviewState());

  void loadOrderData() {
    // Load order data from cart or other sources
    emit(state);
  }

  void updateDeliveryInstructions(String instructions) {
    emit(state.copyWith(deliveryInstructions: instructions));
  }

  void updatePaymentMethod(String paymentMethod) {
    emit(state.copyWith(paymentMethod: paymentMethod));
  }

  void applyPromotionalCode(String code) {
    // Apply promotional code logic here
    // For now, just store the code
    emit(state.copyWith(promotionalCode: code));
  }

  void updateDeliveryTime(String time) {
    emit(state.copyWith(deliveryTime: time));
  }

  void updateAddress(String address) {
    emit(state.copyWith(address: address));
  }

  void calculateTotal() {
    final total = state.orderTotal + state.deliveryFee;
    emit(state.copyWith(total: total));
  }
}
