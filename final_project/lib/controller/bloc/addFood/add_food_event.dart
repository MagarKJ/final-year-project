part of 'add_food_bloc.dart';

@immutable
sealed class AddFoodEvent {}

class AddFoodLoadedEvent extends AddFoodEvent {
  final String url;
  final String url1;

  AddFoodLoadedEvent({
    this.url = '/api/meals',
    this.url1 = '/api/customs',
  });
}

class AddFoodButtonPressedEvent extends AddFoodEvent {
  final dynamic foodName;
  final dynamic foodDescription;
  final dynamic foodCalories;
  final dynamic foodCarbs;
  final dynamic foodProtein;
  final dynamic foodFat;
  final dynamic foodSodium;
  final dynamic image;
  AddFoodButtonPressedEvent({
    required this.foodName,
    required this.foodDescription,
    required this.foodCalories,
    required this.foodCarbs,
    required this.foodProtein,
    required this.foodFat,
    required this.foodSodium,
    required this.image,
  });
}

class AddPremiumFoodButtonPressedEvent extends AddFoodEvent {
  final dynamic foodName;
  final dynamic description;
  final dynamic foodCalories;
  final dynamic foodCarbs;
  final dynamic foodProtein;
  final dynamic foodFat;
  final dynamic foodSodium;
  final dynamic volume;
  final dynamic image;
  final dynamic quality;
  final dynamic type;
  AddPremiumFoodButtonPressedEvent({
    required this.foodName,
    required this.description,
    required this.foodCalories,
    required this.foodCarbs,
    required this.foodProtein,
    required this.foodFat,
    required this.foodSodium,
    required this.volume,
    required this.image,
    required this.quality,
    required this.type,
  });
}

class DeletePremiumFoodEvent extends AddFoodEvent {
  final String foodId;

  DeletePremiumFoodEvent({required this.foodId});
}
