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
