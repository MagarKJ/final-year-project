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
    AllProductRepository allProductRepository = AllProductRepository();
    emit(HomePageLoadingState());
    try {
      dynamic allFood = await allProductRepository.fetchAllProduct();
      // Ensure allFood is a List of Maps
      if (allFood is List) {
        List<ProductDataModel> products = allFood
            .map((e) => ProductDataModel.fromJson(e as Map<String, dynamic>))
            .toList();
        emit(HomePageLoadedState(allProduct: products));
      } else {
        throw Exception('Data format is not a list');
      }
    } catch (ex) {
      emit(HomePageErrorState(message: ex.toString()));
    }
  }
}
