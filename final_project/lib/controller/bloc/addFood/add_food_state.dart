part of 'add_food_bloc.dart';

@immutable
sealed class AddFoodState {}

final class AddFoodInitial extends AddFoodState {}

final class AddFoodLoadingState extends AddFoodState {}

final class AddFoodLoadedState extends AddFoodState {
   List<ProductDataModel> allProduct;

  AddFoodLoadedState({
    required this.allProduct,
  });
}

final class AddFoodErrorState extends AddFoodState {
  final String message;

  AddFoodErrorState({
    required this.message,
  });
}
