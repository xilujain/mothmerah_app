class CategoryTranslationModel {
  final int categoryId;
  final String languageCode;
  final String translatedCategoryName;

  CategoryTranslationModel({
    required this.categoryId,
    required this.languageCode,
    required this.translatedCategoryName,
  });

  factory CategoryTranslationModel.fromJson(Map<String, dynamic> json) {
    return CategoryTranslationModel(
      categoryId: json['category_id'] ?? 0,
      languageCode: json['language_code'] ?? '',
      translatedCategoryName: json['translated_category_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'language_code': languageCode,
      'translated_category_name': translatedCategoryName,
    };
  }
}

class CategoryModel {
  final int categoryId;
  final String categoryNameKey;
  final int? parentCategoryId;
  final String? categoryImageUrl;
  final int? sortOrder;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<CategoryTranslationModel> translations;

  CategoryModel({
    required this.categoryId,
    required this.categoryNameKey,
    this.parentCategoryId,
    this.categoryImageUrl,
    this.sortOrder,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.translations,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['category_id'] ?? 0,
      categoryNameKey: json['category_name_key'] ?? '',
      parentCategoryId: json['parent_category_id'],
      categoryImageUrl: json['category_image_url'],
      sortOrder: json['sort_order'],
      isActive: json['is_active'] ?? true,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      translations:
          (json['translations'] as List<dynamic>?)
              ?.map((t) => CategoryTranslationModel.fromJson(t))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'category_name_key': categoryNameKey,
      'parent_category_id': parentCategoryId,
      'category_image_url': categoryImageUrl,
      'sort_order': sortOrder,
      'is_active': isActive,
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
          : CategoryTranslationModel(
              categoryId: categoryId,
              languageCode: '',
              translatedCategoryName: categoryNameKey,
            ),
    );
    return arabicTranslation.translatedCategoryName;
  }
}
