class OrderReviewState {
  final String deliveryTime;
  final String address;
  final String deliveryInstructions;
  final String paymentMethod;
  final String? promotionalCode;
  final double orderTotal;
  final double deliveryFee;
  final double total;

  OrderReviewState({
    this.deliveryTime = '03:12 - 03:12 م',
    this.address = 'النرجس\nRANB4535M 4535 انس بن مالك، 9140، حي الـ...',
    this.deliveryInstructions = '',
    this.paymentMethod = 'Apple Pay',
    this.promotionalCode,
    this.orderTotal = 10.0,
    this.deliveryFee = 10.0,
    this.total = 20.0,
  });

  OrderReviewState copyWith({
    String? deliveryTime,
    String? address,
    String? deliveryInstructions,
    String? paymentMethod,
    String? promotionalCode,
    double? orderTotal,
    double? deliveryFee,
    double? total,
  }) {
    return OrderReviewState(
      deliveryTime: deliveryTime ?? this.deliveryTime,
      address: address ?? this.address,
      deliveryInstructions: deliveryInstructions ?? this.deliveryInstructions,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      promotionalCode: promotionalCode ?? this.promotionalCode,
      orderTotal: orderTotal ?? this.orderTotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      total: total ?? this.total,
    );
  }
}
