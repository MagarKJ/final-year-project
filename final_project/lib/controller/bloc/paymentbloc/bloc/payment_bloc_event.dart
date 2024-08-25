part of 'payment_bloc_bloc.dart';

@immutable
sealed class PaymentBlocEvent {}

final class PaymentBlocInitialEvent extends PaymentBlocEvent {}
