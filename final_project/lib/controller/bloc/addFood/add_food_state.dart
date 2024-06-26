part of 'add_food_bloc.dart';

@immutable
sealed class AddFoodState {}

final class AddFoodInitial extends AddFoodState {}

final class AddFoodLoadingState extends AddFoodState {}

final class AddFoodLoadedState extends AddFoodState {
  List<ProductDataModel> allProduct;
  List<ProductDataModel> premiumFood;

  AddFoodLoadedState({
    required this.allProduct,
    required this.premiumFood,
  });
}

final class AddFoodErrorState extends AddFoodState {
  final String message;

  AddFoodErrorState({
    required this.message,
  });
}

final class AddFoodButtonPressedLoadingState extends AddFoodState {}

final class AddFoodButtonPressedLoadedState extends AddFoodState {
  List<ProductDataModel> addFood;
  AddFoodButtonPressedLoadedState({
    required this.addFood,
  });
}

final class AddFoodButtonPressedErrorState extends AddFoodState {
  final String message;

  AddFoodButtonPressedErrorState({
    required this.message,
  });
}
