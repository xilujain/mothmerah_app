import 'product_translation_model.dart';
import 'category_model.dart';
import 'product_status_model.dart';
import 'unit_of_measure_model.dart';
import 'packaging_option_model.dart';
import 'product_model.dart';

class ApiProductModel {
  final String productId;
  final String sellerUserId;
  final int categoryId;
  final double basePricePerUnit;
  final int unitOfMeasureId;
  final String countryOfOriginCode;
  final bool isOrganic;
  final bool isLocalSaudiProduct;
  final int productStatusId;
  final String? mainImageUrl;
  final String? sku;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;
  final CategoryModel category;
  final ProductStatusModel status;
  final UnitOfMeasureModel unitOfMeasure;
  final List<ProductTranslationModel> translations;
  final List<PackagingOptionModel> packagingOptions;

  ApiProductModel({
    required this.productId,
    required this.sellerUserId,
    required this.categoryId,
    required this.basePricePerUnit,
    required this.unitOfMeasureId,
    required this.countryOfOriginCode,
    required this.isOrganic,
    required this.isLocalSaudiProduct,
    required this.productStatusId,
    this.mainImageUrl,
    this.sku,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.status,
    required this.unitOfMeasure,
    required this.translations,
    required this.packagingOptions,
  });

  factory ApiProductModel.fromJson(Map<String, dynamic> json) {
    return ApiProductModel(
      productId: json['product_id'] ?? '',
      sellerUserId: json['seller_user_id'] ?? '',
      categoryId: json['category_id'] ?? 0,
      basePricePerUnit: (json['base_price_per_unit'] ?? 0.0).toDouble(),
      unitOfMeasureId: json['unit_of_measure_id'] ?? 0,
      countryOfOriginCode: json['country_of_origin_code'] ?? '',
      isOrganic: json['is_organic'] ?? false,
      isLocalSaudiProduct: json['is_local_saudi_product'] ?? false,
      productStatusId: json['product_status_id'] ?? 0,
      mainImageUrl: json['main_image_url'],
      sku: json['sku'],
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? [],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      category: CategoryModel.fromJson(json['category'] ?? {}),
      status: ProductStatusModel.fromJson(json['status'] ?? {}),
      unitOfMeasure: UnitOfMeasureModel.fromJson(json['unit_of_measure'] ?? {}),
      translations:
          (json['translations'] as List<dynamic>?)
              ?.map((t) => ProductTranslationModel.fromJson(t))
              .toList() ??
          [],
      packagingOptions:
          (json['packaging_options'] as List<dynamic>?)
              ?.map((p) => PackagingOptionModel.fromJson(p))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'seller_user_id': sellerUserId,
      'category_id': categoryId,
      'base_price_per_unit': basePricePerUnit,
      'unit_of_measure_id': unitOfMeasureId,
      'country_of_origin_code': countryOfOriginCode,
      'is_organic': isOrganic,
      'is_local_saudi_product': isLocalSaudiProduct,
      'product_status_id': productStatusId,
      'main_image_url': mainImageUrl,
      'sku': sku,
      'tags': tags,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'category': category.toJson(),
      'status': status.toJson(),
      'unit_of_measure': unitOfMeasure.toJson(),
      'translations': translations.map((t) => t.toJson()).toList(),
      'packaging_options': packagingOptions.map((p) => p.toJson()).toList(),
    };
  }

  // Helper getters for easy access
  String get name {
    final arabicTranslation = translations.firstWhere(
      (t) => t.languageCode == 'ar',
      orElse: () => translations.isNotEmpty
          ? translations.first
          : ProductTranslationModel(
              languageCode: '',
              translatedProductName: 'منتج',
              translatedDescription: '',
            ),
    );
    return arabicTranslation.translatedProductName;
  }

  String get description {
    final arabicTranslation = translations.firstWhere(
      (t) => t.languageCode == 'ar',
      orElse: () => translations.isNotEmpty
          ? translations.first
          : ProductTranslationModel(
              languageCode: '',
              translatedProductName: '',
              translatedDescription: 'وصف المنتج',
            ),
    );
    return arabicTranslation.translatedDescription;
  }

  String get categoryName => category.displayName;
  String get statusName => status.displayName;
  String get unitName => unitOfMeasure.displayName;
  String get unitAbbreviation => unitOfMeasure.abbreviation;

  // Get default packaging option
  PackagingOptionModel? get defaultPackagingOption {
    try {
      return packagingOptions.firstWhere((p) => p.isDefaultOption);
    } catch (e) {
      return packagingOptions.isNotEmpty ? packagingOptions.first : null;
    }
  }

  // Get price for default packaging
  double get price {
    final defaultPackaging = defaultPackagingOption;
    if (defaultPackaging != null) {
      return defaultPackaging.basePrice;
    }
    return basePricePerUnit;
  }

  // Convert to ProductModel for compatibility with existing code
  ProductModel toProductModel() {
    return ProductModel(
      id: productId,
      name: name,
      description: description,
      price: price,
      imageUrl: mainImageUrl ?? 'assets/images/default_product.png',
      category: categoryName,
      weight:
          '${defaultPackagingOption?.quantityInPackaging.toStringAsFixed(1)} ${unitAbbreviation}',
      calories: 0, // Not available in API
      quantity: 1,
      isLimited: false, // Not available in API
      isLocal: isLocalSaudiProduct,
    );
  }
}
