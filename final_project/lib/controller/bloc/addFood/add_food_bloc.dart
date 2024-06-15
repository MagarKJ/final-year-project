import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/product_data_model.dart';
import '../../apis/all_product_repository.dart';

part 'add_food_event.dart';
part 'add_food_state.dart';

class AddFoodBloc extends Bloc<AddFoodEvent, AddFoodState> {
  AddFoodBloc() : super(AddFoodInitial()) {
    on<AddFoodLoadedEvent>(_onAddFoodLoadedEvent);
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
      List<dynamic> meals = allFood['meals'];
      // Ensure allFood is a List of Maps
      emit(AddFoodLoadedState(
          allProduct:
              meals.map((meals) => ProductDataModel.fromJson(meals)).toList()));
    } catch (ex) {
      emit(AddFoodErrorState(message: ex.toString()));
    }
  }
}
