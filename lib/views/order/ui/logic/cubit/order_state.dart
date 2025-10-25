import 'package:mothmerah_app/views/order/data/order_response_model.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {
  final OrderResponseModel orderResponse;

  OrderSuccess({required this.orderResponse});
}

class OrderError extends OrderState {
  final String error;

  OrderError({required this.error});
}

class OrderSubmitted extends OrderState {
  final String orderId;
  final double totalAmount;
  final String currencyCode;

  OrderSubmitted({
    required this.orderId,
    required this.totalAmount,
    required this.currencyCode,
  });
}
