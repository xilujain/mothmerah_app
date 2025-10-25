class OrderItemModel {
  final int productPackagingOptionId;
  final String sellerUserId;
  final int quantityOrdered;
  final double unitPriceAtPurchase;
  final double totalPriceForItem;
  final int itemStatusId;
  final String notes;

  OrderItemModel({
    required this.productPackagingOptionId,
    required this.sellerUserId,
    required this.quantityOrdered,
    required this.unitPriceAtPurchase,
    required this.totalPriceForItem,
    required this.itemStatusId,
    required this.notes,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      productPackagingOptionId: json['product_packaging_option_id'] ?? 0,
      sellerUserId: json['seller_user_id'] ?? '',
      quantityOrdered: json['quantity_ordered'] ?? 0,
      unitPriceAtPurchase: (json['unit_price_at_purchase'] ?? 0.0).toDouble(),
      totalPriceForItem: (json['total_price_for_item'] ?? 0.0).toDouble(),
      itemStatusId: json['item_status_id'] ?? 0,
      notes: json['notes'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_packaging_option_id': productPackagingOptionId,
      'seller_user_id': sellerUserId,
      'quantity_ordered': quantityOrdered,
      'unit_price_at_purchase': unitPriceAtPurchase,
      'total_price_for_item': totalPriceForItem,
      'item_status_id': itemStatusId,
      'notes': notes,
    };
  }

  OrderItemModel copyWith({
    int? productPackagingOptionId,
    String? sellerUserId,
    int? quantityOrdered,
    double? unitPriceAtPurchase,
    double? totalPriceForItem,
    int? itemStatusId,
    String? notes,
  }) {
    return OrderItemModel(
      productPackagingOptionId: productPackagingOptionId ?? this.productPackagingOptionId,
      sellerUserId: sellerUserId ?? this.sellerUserId,
      quantityOrdered: quantityOrdered ?? this.quantityOrdered,
      unitPriceAtPurchase: unitPriceAtPurchase ?? this.unitPriceAtPurchase,
      totalPriceForItem: totalPriceForItem ?? this.totalPriceForItem,
      itemStatusId: itemStatusId ?? this.itemStatusId,
      notes: notes ?? this.notes,
    );
  }
}
