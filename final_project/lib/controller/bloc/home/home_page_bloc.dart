import 'dart:async';
import 'dart:developer';

import 'package:final_project/controller/apis/add_food_repository.dart';
import 'package:final_project/controller/apis/daily_total_nutrients.dart';
import 'package:final_project/model/nutrients_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/product_data_model.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<HomePageLoadEvent>(_onHomePageLoaded);
    on<RemoveSpecificFoodEvent>(_onRemoveSpecificFoodEvent);
    on<RemoveAllMealsEvent>(onRemoveAllMealsEvent);
  }

  void _onHomePageLoaded(
    HomePageLoadEvent event,
    Emitter<HomePageState> emit,
  ) async {
    AddFoodRepository addFoodRepositorym = AddFoodRepository();
    DailyNutrients dailyNutrients = DailyNutrients();

    emit(HomePageLoadingState());
    try {
      dynamic allFood = await addFoodRepositorym.fetchAddedFood();
      dynamic allNutrients = await dailyNutrients.fetchDailyNutrients();
      List<dynamic> meals = allFood['Meals'];
      Map<String, dynamic> nutrients = allNutrients['data'];

      List<ProductDataModel> products =
          meals.map((meals) => ProductDataModel.fromJson(meals)).toList();
      NutrientsModel nutrientsModel = NutrientsModel.fromJson(nutrients);

      emit(HomePageLoadedState(
          allProduct: products, nutrients: [nutrientsModel]));
    } catch (ex) {
      emit(HomePageErrorState(message: ex.toString()));
    }
  }

  FutureOr<void> _onRemoveSpecificFoodEvent(
    RemoveSpecificFoodEvent event,
    Emitter<HomePageState> emit,
  ) async {
    try {
      AddFoodRepository addFoodRepository = AddFoodRepository();

      dynamic removeFood =
          await addFoodRepository.removeSpecificMeal(foodID: event.foodID);
      emit(RemoveSpecificFoodState(message: removeFood['message']));
    } catch (e) {
      emit(RemoveSpecificFoodErrorState(message: e.toString()));
    }
  }

  FutureOr<void> onRemoveAllMealsEvent(
    RemoveAllMealsEvent event,
    Emitter<HomePageState> emit,
  ) async {
    try {
      AddFoodRepository addFoodRepository = AddFoodRepository();

      dynamic removeFood = await addFoodRepository.removeAllDailyMeals();
      emit(RemoveAllMealsState(message: removeFood['message']));
    } catch (e) {
      emit(RemoveAllMealsErrorState(message: e.toString()));
    }
  }
}
