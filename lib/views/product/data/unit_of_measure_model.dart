class UnitOfMeasureTranslationModel {
  final String languageCode;
  final String translatedUnitName;
  final String translatedUnitAbbreviation;

  UnitOfMeasureTranslationModel({
    required this.languageCode,
    required this.translatedUnitName,
    required this.translatedUnitAbbreviation,
  });

  factory UnitOfMeasureTranslationModel.fromJson(Map<String, dynamic> json) {
    return UnitOfMeasureTranslationModel(
      languageCode: json['language_code'] ?? '',
      translatedUnitName: json['translated_unit_name'] ?? '',
      translatedUnitAbbreviation: json['translated_unit_abbreviation'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'language_code': languageCode,
      'translated_unit_name': translatedUnitName,
      'translated_unit_abbreviation': translatedUnitAbbreviation,
    };
  }
}

class UnitOfMeasureModel {
  final int unitId;
  final String unitNameKey;
  final bool isActive;
  final List<UnitOfMeasureTranslationModel> translations;

  UnitOfMeasureModel({
    required this.unitId,
    required this.unitNameKey,
    required this.isActive,
    required this.translations,
  });

  factory UnitOfMeasureModel.fromJson(Map<String, dynamic> json) {
    return UnitOfMeasureModel(
      unitId: json['unit_id'] ?? 0,
      unitNameKey: json['unit_name_key'] ?? '',
      isActive: json['is_active'] ?? true,
      translations:
          (json['translations'] as List<dynamic>?)
              ?.map((t) => UnitOfMeasureTranslationModel.fromJson(t))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unit_id': unitId,
      'unit_name_key': unitNameKey,
      'is_active': isActive,
      'translations': translations.map((t) => t.toJson()).toList(),
    };
  }

  String get displayName {
    final arabicTranslation = translations.firstWhere(
      (t) => t.languageCode == 'ar',
      orElse: () => translations.isNotEmpty
          ? translations.first
          : UnitOfMeasureTranslationModel(
              languageCode: '',
              translatedUnitName: unitNameKey,
              translatedUnitAbbreviation: '',
            ),
    );
    return arabicTranslation.translatedUnitName;
  }

  String get abbreviation {
    final arabicTranslation = translations.firstWhere(
      (t) => t.languageCode == 'ar',
      orElse: () => translations.isNotEmpty
          ? translations.first
          : UnitOfMeasureTranslationModel(
              languageCode: '',
              translatedUnitName: unitNameKey,
              translatedUnitAbbreviation: '',
            ),
    );
    return arabicTranslation.translatedUnitAbbreviation;
  }
}
