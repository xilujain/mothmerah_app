class OrderResponseModel {
  final String orderId;
  final String status;
  final String message;
  final double totalAmount;
  final String currencyCode;
  final DateTime createdAt;

  OrderResponseModel({
    required this.orderId,
    required this.status,
    required this.message,
    required this.totalAmount,
    required this.currencyCode,
    required this.createdAt,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderResponseModel(
      orderId: json['order_id'] ?? json['id'] ?? '',
      status: json['status'] ?? '',
      message: json['message'] ?? 'تم إنشاء الطلب بنجاح',
      totalAmount: (json['total_amount'] ?? json['final_total_amount'] ?? 0.0).toDouble(),
      currencyCode: json['currency_code'] ?? 'SAR',
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'status': status,
      'message': message,
      'total_amount': totalAmount,
      'currency_code': currencyCode,
      'created_at': createdAt.toIso8601String(),
    };
  }

  OrderResponseModel copyWith({
    String? orderId,
    String? status,
    String? message,
    double? totalAmount,
    String? currencyCode,
    DateTime? createdAt,
  }) {
    return OrderResponseModel(
      orderId: orderId ?? this.orderId,
      status: status ?? this.status,
      message: message ?? this.message,
      totalAmount: totalAmount ?? this.totalAmount,
      currencyCode: currencyCode ?? this.currencyCode,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
