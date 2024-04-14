import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<HomePageLoadEvent>(_onHomePageLoded);
  }
  void _onHomePageLoded(
    HomePageLoadEvent event,
    Emitter<HomePageState> emit,
  ) async {
    emit(HomePageLoadingState());
    try {
      await Future.delayed(const Duration(seconds: 1), () {
        emit(HomePageLoadedState());
      });
      emit(HomePageInitial());
    } catch (e) {
      emit(HomePageErrorState(message: e.toString()));
    }
  }
}
