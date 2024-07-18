class AnalticsModel {
  final int id;
  final int userId;
  final String calories;
  final String carbs;
  final String fat;
  final String protein;
  final String sodium;
  final String volume;
  final String steps;
  final String date;

  AnalticsModel({
    required this.id,
    required this.userId,
    required this.calories,
    required this.carbs,
    required this.fat,
    required this.protein,
    required this.sodium,
    required this.volume,
    required this.steps,
    required this.date,
  });

  factory AnalticsModel.fromJson(Map<String, dynamic> json) {
    return AnalticsModel(
      id: json['id'],
      userId: json['user_id'],
      calories: json['calories'],
      carbs: json['carbohydrate'],
      fat: json['fat'],
      protein: json['protein'],
      sodium: json['sodium'],
      volume: json['volume'],
      steps: json['steps'],
      date: json['created_at'],
    );
  }
}
