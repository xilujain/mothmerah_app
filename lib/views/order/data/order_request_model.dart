import 'order_item_model.dart';

class OrderRequestModel {
  final String sellerUserId;
  final int shippingAddressId;
  final int billingAddressId;
  final int paymentStatusId;
  final String sourceOfOrder;
  final int relatedQuoteId;
  final int relatedAuctionSettlementId;
  final String notesFromBuyer;
  final String notesFromSeller;
  final double totalAmountBeforeDiscount;
  final double discountAmount;
  final double totalAmountAfterDiscount;
  final double vatAmount;
  final double finalTotalAmount;
  final String currencyCode;
  final List<OrderItemModel> items;

  OrderRequestModel({
    required this.sellerUserId,
    required this.shippingAddressId,
    required this.billingAddressId,
    required this.paymentStatusId,
    required this.sourceOfOrder,
    required this.relatedQuoteId,
    required this.relatedAuctionSettlementId,
    required this.notesFromBuyer,
    required this.notesFromSeller,
    required this.totalAmountBeforeDiscount,
    required this.discountAmount,
    required this.totalAmountAfterDiscount,
    required this.vatAmount,
    required this.finalTotalAmount,
    required this.currencyCode,
    required this.items,
  });

  factory OrderRequestModel.fromJson(Map<String, dynamic> json) {
    return OrderRequestModel(
      sellerUserId: json['seller_user_id'] ?? '',
      shippingAddressId: json['shipping_address_id'] ?? 0,
      billingAddressId: json['billing_address_id'] ?? 0,
      paymentStatusId: json['payment_status_id'] ?? 0,
      sourceOfOrder: json['source_of_order'] ?? '',
      relatedQuoteId: json['related_quote_id'] ?? 0,
      relatedAuctionSettlementId: json['related_auction_settlement_id'] ?? 0,
      notesFromBuyer: json['notes_from_buyer'] ?? '',
      notesFromSeller: json['notes_from_seller'] ?? '',
      totalAmountBeforeDiscount: (json['total_amount_before_discount'] ?? 0.0).toDouble(),
      discountAmount: (json['discount_amount'] ?? 0.0).toDouble(),
      totalAmountAfterDiscount: (json['total_amount_after_discount'] ?? 0.0).toDouble(),
      vatAmount: (json['vat_amount'] ?? 0.0).toDouble(),
      finalTotalAmount: (json['final_total_amount'] ?? 0.0).toDouble(),
      currencyCode: json['currency_code'] ?? 'SAR',
      items: (json['items'] as List<dynamic>?)
          ?.map((item) => OrderItemModel.fromJson(item))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seller_user_id': sellerUserId,
      'shipping_address_id': shippingAddressId,
      'billing_address_id': billingAddressId,
      'payment_status_id': paymentStatusId,
      'source_of_order': sourceOfOrder,
      'related_quote_id': relatedQuoteId,
      'related_auction_settlement_id': relatedAuctionSettlementId,
      'notes_from_buyer': notesFromBuyer,
      'notes_from_seller': notesFromSeller,
      'total_amount_before_discount': totalAmountBeforeDiscount,
      'discount_amount': discountAmount,
      'total_amount_after_discount': totalAmountAfterDiscount,
      'vat_amount': vatAmount,
      'final_total_amount': finalTotalAmount,
      'currency_code': currencyCode,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  OrderRequestModel copyWith({
    String? sellerUserId,
    int? shippingAddressId,
    int? billingAddressId,
    int? paymentStatusId,
    String? sourceOfOrder,
    int? relatedQuoteId,
    int? relatedAuctionSettlementId,
    String? notesFromBuyer,
    String? notesFromSeller,
    double? totalAmountBeforeDiscount,
    double? discountAmount,
    double? totalAmountAfterDiscount,
    double? vatAmount,
    double? finalTotalAmount,
    String? currencyCode,
    List<OrderItemModel>? items,
  }) {
    return OrderRequestModel(
      sellerUserId: sellerUserId ?? this.sellerUserId,
      shippingAddressId: shippingAddressId ?? this.shippingAddressId,
      billingAddressId: billingAddressId ?? this.billingAddressId,
      paymentStatusId: paymentStatusId ?? this.paymentStatusId,
      sourceOfOrder: sourceOfOrder ?? this.sourceOfOrder,
      relatedQuoteId: relatedQuoteId ?? this.relatedQuoteId,
      relatedAuctionSettlementId: relatedAuctionSettlementId ?? this.relatedAuctionSettlementId,
      notesFromBuyer: notesFromBuyer ?? this.notesFromBuyer,
      notesFromSeller: notesFromSeller ?? this.notesFromSeller,
      totalAmountBeforeDiscount: totalAmountBeforeDiscount ?? this.totalAmountBeforeDiscount,
      discountAmount: discountAmount ?? this.discountAmount,
      totalAmountAfterDiscount: totalAmountAfterDiscount ?? this.totalAmountAfterDiscount,
      vatAmount: vatAmount ?? this.vatAmount,
      finalTotalAmount: finalTotalAmount ?? this.finalTotalAmount,
      currencyCode: currencyCode ?? this.currencyCode,
      items: items ?? this.items,
    );
  }
}
