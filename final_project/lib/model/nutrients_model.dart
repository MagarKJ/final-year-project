class NutrientsModel {
  final String totalCalories;
  final String totalFats;
  final String totalProtein;
  final String totalCarbs;
  final String totalSodium;
  final String totalVolume;

  NutrientsModel({
    required this.totalCalories,
    required this.totalFats,
    required this.totalProtein,
    required this.totalCarbs,
    required this.totalSodium,
    required this.totalVolume,
  });

  factory NutrientsModel.fromJson(Map<String, dynamic> json) {
    return NutrientsModel(
      totalCalories: json['Total Calories'].toString(),
      totalFats: json['Total Fat'].toString(),
      totalProtein: json['Total Protein'].toString(),
      totalCarbs: json['Total Carbohydrate'].toString(),
      totalSodium: json['Total Sodium'].toString(),
      totalVolume: json['Total Volume'].toString(),
    );
  }
}
