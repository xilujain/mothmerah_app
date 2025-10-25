class ProductStatusTranslationModel {
  final int productStatusId;
  final String languageCode;
  final String translatedStatusName;

  ProductStatusTranslationModel({
    required this.productStatusId,
    required this.languageCode,
    required this.translatedStatusName,
  });

  factory ProductStatusTranslationModel.fromJson(Map<String, dynamic> json) {
    return ProductStatusTranslationModel(
      productStatusId: json['product_status_id'] ?? 0,
      languageCode: json['language_code'] ?? '',
      translatedStatusName: json['translated_status_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_status_id': productStatusId,
      'language_code': languageCode,
      'translated_status_name': translatedStatusName,
    };
  }
}

class ProductStatusModel {
  final int productStatusId;
  final String statusNameKey;
  final List<ProductStatusTranslationModel> translations;

  ProductStatusModel({
    required this.productStatusId,
    required this.statusNameKey,
    required this.translations,
  });

  factory ProductStatusModel.fromJson(Map<String, dynamic> json) {
    return ProductStatusModel(
      productStatusId: json['product_status_id'] ?? 0,
      statusNameKey: json['status_name_key'] ?? '',
      translations:
          (json['translations'] as List<dynamic>?)
              ?.map((t) => ProductStatusTranslationModel.fromJson(t))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_status_id': productStatusId,
      'status_name_key': statusNameKey,
      'translations': translations.map((t) => t.toJson()).toList(),
    };
  }

  String get displayName {
    final arabicTranslation = translations.firstWhere(
      (t) => t.languageCode == 'ar',
      orElse: () => translations.isNotEmpty
          ? translations.first
          : ProductStatusTranslationModel(
              productStatusId: productStatusId,
              languageCode: '',
              translatedStatusName: statusNameKey,
            ),
    );
    return arabicTranslation.translatedStatusName;
  }
}
