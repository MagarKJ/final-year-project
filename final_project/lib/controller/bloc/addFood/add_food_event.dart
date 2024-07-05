part of 'add_food_bloc.dart';

@immutable
sealed class AddFoodEvent {}

class AddFoodLoadedEvent extends AddFoodEvent {}

class AddFoodButtonPressedEvent extends AddFoodEvent {
  final dynamic foodName;
  final dynamic foodCalories;
  final dynamic foodCarbs;
  final dynamic foodProtein;
  final dynamic foodFat;
  final dynamic foodSodium;
  AddFoodButtonPressedEvent({
    required this.foodName,
    required this.foodCalories,
    required this.foodCarbs,
    required this.foodProtein,
    required this.foodFat,
    required this.foodSodium,
  });
}
