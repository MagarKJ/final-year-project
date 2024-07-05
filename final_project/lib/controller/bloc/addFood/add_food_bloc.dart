import 'dart:async';
import 'dart:developer';

import 'package:final_project/controller/apis/add_food_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/product_data_model.dart';
import '../../apis/all_product_repository.dart';

part 'add_food_event.dart';
part 'add_food_state.dart';

class AddFoodBloc extends Bloc<AddFoodEvent, AddFoodState> {
  AddFoodBloc() : super(AddFoodInitial()) {
    on<AddFoodLoadedEvent>(_onAddFoodLoadedEvent);
    on<AddFoodButtonPressedEvent>(_onAddFoodButtonPressedEvent);
  }

  FutureOr<void> _onAddFoodLoadedEvent(
    AddFoodLoadedEvent event,
    Emitter<AddFoodState> emit,
  ) async {
    AllProductRepository allProductRepository = AllProductRepository();

    emit(AddFoodLoadingState());
    try {
      // Fetch all products
      dynamic allFood = await allProductRepository.fetchAllProduct();
      dynamic premiumFood = await allProductRepository.fetchPremiumProducts();
      List<dynamic> meals = allFood['meals'];
      List<dynamic> premiumFoods = premiumFood['Meals'];
      // Ensure allFood is a List of Maps
      emit(
        AddFoodLoadedState(
          allProduct:
              meals.map((meals) => ProductDataModel.fromJson(meals)).toList(),
          premiumFood: premiumFoods
              .map((premiumFoods) => ProductDataModel.fromJson(premiumFoods))
              .toList(),
        ),
      );
    } catch (ex) {
      emit(AddFoodErrorState(message: ex.toString()));
    }
  }

  FutureOr<void> _onAddFoodButtonPressedEvent(
    AddFoodButtonPressedEvent event,
    Emitter<AddFoodState> emit,
  ) async {
    try {
      AddFoodRepository addFoodRepository = AddFoodRepository();
      emit(AddFoodButtonPressedLoadingState());
      dynamic addFood = await addFoodRepository.addFood(
        foodName: event.foodName,
        foodCalories: event.foodCalories,
        foodCarbs: event.foodCarbs,
        foodProtein: event.foodProtein,
        foodFat: event.foodFat,
        foodSodium: event.foodSodium,
      );

      emit(
        AddFoodButtonPressedLoadedState(addFood: addFood),
      );
    } catch (ex) {
      emit(AddFoodButtonPressedErrorState(message: ex.toString()));
    }
  }
}
