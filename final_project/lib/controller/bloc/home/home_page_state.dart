part of 'home_page_bloc.dart';

@immutable
sealed class HomePageState {}

final class HomePageInitial extends HomePageState {}

final class HomePageLoadingState extends HomePageState {}

final class HomePageLoadedState extends HomePageState {
  List<ProductDataModel> allProduct;

  HomePageLoadedState({
    required this.allProduct,
  });
}

final class HomePageErrorState extends HomePageState {
  final String message;

  HomePageErrorState({
    required this.message,
  });
}

final class RemoveSpecificFoodState extends HomePageState {
  final String message;

  RemoveSpecificFoodState({
    required this.message,
  });
}

final class RemoveSpecificFoodErrorState extends HomePageState {
  final String message;

  RemoveSpecificFoodErrorState({
    required this.message,
  });
}

final class RemoveAllMealsState extends HomePageState {
  final String message;

  RemoveAllMealsState({
    required this.message,
  });
}

final class RemoveAllMealsErrorState extends HomePageState {
  final String message;

  RemoveAllMealsErrorState({
    required this.message,
  });
}