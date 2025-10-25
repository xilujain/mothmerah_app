class PackagingOptionTranslationModel {
  final String languageCode;
  final String translatedPackagingName;

  PackagingOptionTranslationModel({
    required this.languageCode,
    required this.translatedPackagingName,
  });

  factory PackagingOptionTranslationModel.fromJson(Map<String, dynamic> json) {
    return PackagingOptionTranslationModel(
      languageCode: json['language_code'] ?? '',
      translatedPackagingName: json['translated_packaging_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'language_code': languageCode,
      'translated_packaging_name': translatedPackagingName,
    };
  }
}

class PackagingOptionModel {
  final int packagingOptionId;
  final String productId;
  final String packagingOptionNameKey;
  final String? customPackagingDescription;
  final double quantityInPackaging;
  final int unitOfMeasureIdForQuantity;
  final double basePrice;
  final String? sku;
  final String? barcode;
  final bool isDefaultOption;
  final bool isActive;
  final int? sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<PackagingOptionTranslationModel> translations;

  PackagingOptionModel({
    required this.packagingOptionId,
    required this.productId,
    required this.packagingOptionNameKey,
    this.customPackagingDescription,
    required this.quantityInPackaging,
    required this.unitOfMeasureIdForQuantity,
    required this.basePrice,
    this.sku,
    this.barcode,
    required this.isDefaultOption,
    required this.isActive,
    this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
    required this.translations,
  });

  factory PackagingOptionModel.fromJson(Map<String, dynamic> json) {
    return PackagingOptionModel(
      packagingOptionId: json['packaging_option_id'] ?? 0,
      productId: json['product_id'] ?? '',
      packagingOptionNameKey: json['packaging_option_name_key'] ?? '',
      customPackagingDescription: json['custom_packaging_description'],
      quantityInPackaging: (json['quantity_in_packaging'] ?? 0.0).toDouble(),
      unitOfMeasureIdForQuantity: json['unit_of_measure_id_for_quantity'] ?? 0,
      basePrice: (json['base_price'] ?? 0.0).toDouble(),
      sku: json['sku'],
      barcode: json['barcode'],
      isDefaultOption: json['is_default_option'] ?? false,
      isActive: json['is_active'] ?? true,
      sortOrder: json['sort_order'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      translations:
          (json['translations'] as List<dynamic>?)
              ?.map((t) => PackagingOptionTranslationModel.fromJson(t))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'packaging_option_id': packagingOptionId,
      'product_id': productId,
      'packaging_option_name_key': packagingOptionNameKey,
      'custom_packaging_description': customPackagingDescription,
      'quantity_in_packaging': quantityInPackaging,
      'unit_of_measure_id_for_quantity': unitOfMeasureIdForQuantity,
      'base_price': basePrice,
      'sku': sku,
      'barcode': barcode,
      'is_default_option': isDefaultOption,
      'is_active': isActive,
      'sort_order': sortOrder,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'translations': translations.map((t) => t.toJson()).toList(),
    };
  }

  String get displayName {
    final arabicTranslation = translations.firstWhere(
      (t) => t.languageCode == 'ar',
      orElse: () => translations.isNotEmpty
          ? translations.first
          : PackagingOptionTranslationModel(
              languageCode: '',
              translatedPackagingName: packagingOptionNameKey,
            ),
    );
    return arabicTranslation.translatedPackagingName;
  }
}
