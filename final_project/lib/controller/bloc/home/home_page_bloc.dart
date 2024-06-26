import 'package:final_project/controller/apis/add_food_repository.dart';
import 'package:final_project/controller/apis/all_product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/product_data_model.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<HomePageLoadEvent>(_onHomePageLoaded);
  }

  void _onHomePageLoaded(
    HomePageLoadEvent event,
    Emitter<HomePageState> emit,
  ) async {
    AddFoodRepository addFoodRepositorym = AddFoodRepository();
    emit(HomePageLoadingState());
    try {
      dynamic allFood = await addFoodRepositorym.fetchAddedFood();
      List<dynamic> meals = allFood['Meals'];
      // Ensure allFood is a List of Maps

      List<ProductDataModel> products =
          meals.map((meals) => ProductDataModel.fromJson(meals)).toList();
      emit(HomePageLoadedState(allProduct: products));
    } catch (ex) {
      emit(HomePageErrorState(message: ex.toString()));
    }
  }
}
