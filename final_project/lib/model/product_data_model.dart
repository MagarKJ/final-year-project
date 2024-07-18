class ProductDataModel {
  final String id;
  final String userId;
  final String name;
  final String description;
  final String calories;
  final String fats;
  final String protein;
  final String carbs;
  final String sodium;
  final String? volume;
  // final double price;
  final String? imageUrl;

  ProductDataModel({
    required this.id,
    required this.name,
    required this.description,
    required this.userId,
    required this.calories,
    required this.fats,
    required this.protein,
    required this.carbs,
    required this.sodium,
    this.volume,
    this.imageUrl,
  });

  factory ProductDataModel.fromJson(Map<String, dynamic> json) {
    return ProductDataModel(
      id: json['id'].toString(),
      userId: json['user_id'].toString(),
      name: json['name'],
      description: json['description'] ?? '',
      calories: json['calories'].toString(),
      fats: json['fat'].toString(),
      protein: json['protein'].toString(),
      carbs: json['carbohydrate'].toString(),
      sodium: json['sodium'].toString(),
      volume: json['volume'].toString(),
      // price: (json['price'] as num).toDouble(),
      imageUrl: json['photo_name'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'name': name,
        'description': description,
        'calories': calories,
        'fat': fats,
        'protein': protein,
        'carbohydrate': carbs,
        'sodium': sodium,
        'volume': volume,
        // 'price': price,
        'photo_name': imageUrl,
      };
}
