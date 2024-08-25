part of 'payment_bloc_bloc.dart';

@immutable
sealed class PaymentBlocState {}

final class PaymentBlocInitial extends PaymentBlocState {}

final class PaymentBlocLoading extends PaymentBlocState {}

final class PaymentBlocLoaded extends PaymentBlocState {
  final List<PaymentDetails> paymentDataModel;

  PaymentBlocLoaded({
    required this.paymentDataModel,
  });
}

final class PaymentBlocError extends PaymentBlocState {
  final String message;

  PaymentBlocError({
    required this.message,
  });
}
