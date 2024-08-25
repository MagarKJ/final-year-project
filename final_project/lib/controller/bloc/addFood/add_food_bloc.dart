import 'dart:async';
import 'dart:developer';

import 'package:final_project/controller/apis/add_food_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../model/product_data_model.dart';
import '../../apis/all_product_repository.dart';

part 'add_food_event.dart';
part 'add_food_state.dart';

class AddFoodBloc extends Bloc<AddFoodEvent, AddFoodState> {
  AddFoodBloc() : super(AddFoodInitial()) {
    on<AddFoodLoadedEvent>(_onAddFoodLoadedEvent);
    on<AddFoodButtonPressedEvent>(_onAddFoodButtonPressedEvent);
    on<AddPremiumFoodButtonPressedEvent>(_onAddPremiumFoodButtonPressedEvent);
    on<DeletePremiumFoodEvent>(_onDeletePremiumFoodEvent);
  }

  void _onAddFoodLoadedEvent(
    AddFoodLoadedEvent event,
    Emitter<AddFoodState> emit,
  ) async {
    AllProductRepository allProductRepository = AllProductRepository();

    emit(AddFoodLoadingState());
    try {
      String url = event.url;
      String url1 = event.url1;
      // Fetch all products
      dynamic allFood = await allProductRepository.fetchAllProduct(url: url);
      dynamic premiumFood =
          await allProductRepository.fetchPremiumProducts(url: url1);
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
        foodDescription: event.foodDescription,
        foodCalories: event.foodCalories,
        foodCarbs: event.foodCarbs,
        foodProtein: event.foodProtein,
        foodFat: event.foodFat,
        foodSodium: event.foodSodium,
        image: event.image,
      );
      Fluttertoast.showToast(
          msg: addFood['message'],
          backgroundColor: addFood['message'] == 'New Meal Added'
              ? Colors.green
              : Colors.red);

      emit(
        AddFoodButtonPressedLoadedState(addFood: addFood),
      );
    } catch (ex) {
      emit(AddFoodButtonPressedErrorState(message: ex.toString()));
    }
  }

  FutureOr<void> _onAddPremiumFoodButtonPressedEvent(
    AddPremiumFoodButtonPressedEvent event,
    Emitter<AddFoodState> emit,
  ) async {
    try {
      AddFoodRepository addFoodRepository = AddFoodRepository();
      emit(AddPremiumFoodButtonPressedLoadingState());
      dynamic addPremiumFood = await addFoodRepository.addPremiumFood(
        foodName: event.foodName,
        description: event.description,
        foodCalories: event.foodCalories,
        foodCarbs: event.foodCarbs,
        foodProtein: event.foodProtein,
        foodFat: event.foodFat,
        foodSodium: event.foodSodium,
        volume: event.volume,
        image: event.image,
        quality: event.quality,
        type: event.type,
      );
      emit(AddPremiumFoodButtonPressedLoadedState(
          addPremiumFood: addPremiumFood));
    } catch (e) {
      log(e.toString());
      emit(AddPremiumFoodButtonPressedErrorState(message: e.toString()));
    }
  }

  FutureOr<void> _onDeletePremiumFoodEvent(
    DeletePremiumFoodEvent event,
    Emitter<AddFoodState> emit,
  ) async {
    try {
      AddFoodRepository addFoodRepository = AddFoodRepository();

      await addFoodRepository.deletePremiumFood(foodId: event.foodId);
      Fluttertoast.showToast(msg: 'Premium meal deleted');
    } catch (e) {
      log(e.toString());
    }
  }
}
