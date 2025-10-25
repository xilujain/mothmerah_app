class ProductTranslationModel {
  final String languageCode;
  final String translatedProductName;
  final String translatedDescription;
  final String? translatedShortDescription;

  ProductTranslationModel({
    required this.languageCode,
    required this.translatedProductName,
    required this.translatedDescription,
    this.translatedShortDescription,
  });

  factory ProductTranslationModel.fromJson(Map<String, dynamic> json) {
    return ProductTranslationModel(
      languageCode: json['language_code'] ?? '',
      translatedProductName: json['translated_product_name'] ?? '',
      translatedDescription: json['translated_description'] ?? '',
      translatedShortDescription: json['translated_short_description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'language_code': languageCode,
      'translated_product_name': translatedProductName,
      'translated_description': translatedDescription,
      'translated_short_description': translatedShortDescription,
    };
  }

  ProductTranslationModel copyWith({
    String? languageCode,
    String? translatedProductName,
    String? translatedDescription,
    String? translatedShortDescription,
  }) {
    return ProductTranslationModel(
      languageCode: languageCode ?? this.languageCode,
      translatedProductName:
          translatedProductName ?? this.translatedProductName,
      translatedDescription:
          translatedDescription ?? this.translatedDescription,
      translatedShortDescription:
          translatedShortDescription ?? this.translatedShortDescription,
    );
  }
}
