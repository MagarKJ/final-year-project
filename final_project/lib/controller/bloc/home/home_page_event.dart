part of 'home_page_bloc.dart';

@immutable
sealed class HomePageEvent {}

class HomePageLoadEvent extends HomePageEvent {}

class RemoveSpecificFoodEvent extends HomePageEvent {
  final dynamic foodID;

  RemoveSpecificFoodEvent({
    required this.foodID,
  });
}
class RemoveAllMealsEvent extends HomePageEvent {
  
}
