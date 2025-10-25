class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final String weight;
  final int calories;
  final bool isLimited;
  final bool isLocal;
  final int quantity;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.weight,
    required this.calories,
    this.isLimited = false,
    this.isLocal = false,
    this.quantity = 1,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
      category: json['category'] ?? '',
      weight: json['weight'] ?? '',
      calories: json['calories'] ?? 0,
      isLimited: json['isLimited'] ?? false,
      isLocal: json['isLocal'] ?? false,
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'weight': weight,
      'calories': calories,
      'isLimited': isLimited,
      'isLocal': isLocal,
      'quantity': quantity,
    };
  }

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    String? category,
    String? weight,
    int? calories,
    bool? isLimited,
    bool? isLocal,
    int? quantity,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      weight: weight ?? this.weight,
      calories: calories ?? this.calories,
      isLimited: isLimited ?? this.isLimited,
      isLocal: isLocal ?? this.isLocal,
      quantity: quantity ?? this.quantity,
    );
  }
}

