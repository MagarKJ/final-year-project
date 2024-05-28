class ProductDataModel {
  final String id;
  final String userId;
  final String name;
  final String calories;
  final String fats;
  final String water;
  final String carbs;
  final String sleep;
  // final double price;
  // final String imageUrl;

  ProductDataModel({
    required this.id,
    required this.name,
    // required this.price,
    // required this.imageUrl,
    required this.userId,
    required this.calories,
    required this.fats,
    required this.water,
    required this.carbs,
    required this.sleep,
  });

  factory ProductDataModel.fromJson(Map<String, dynamic> json) {
    return ProductDataModel(
      id: json['id'].toString(),
      userId: json['user_id'].toString(),
      name: json['name'],
      calories: json['calories'].toString(),
      fats: json['fats'].toString(),
      water: json['water'].toString(),
      carbs: json['carbohydrates'].toString(),
      sleep: json['sleep'].toString(),
      // price: (json['price'] as num).toDouble(),
      // imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'name': name,
        'calories': calories,
        'fats': fats,
        'water': water,
        'carbohydrates': carbs,
        'sleep': sleep,
        // 'price': price,
        // 'imageUrl': imageUrl,
      };
}
