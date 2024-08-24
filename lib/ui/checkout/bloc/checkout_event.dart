part of 'checkout_bloc.dart';

abstract class CheckoutEvent {}

class UpdateShippingInformation extends CheckoutEvent {
  final String name;
  final String address;
  final String city;
  final String state;
  final String zip;

  UpdateShippingInformation({
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.zip,
  });
}

class SelectPaymentMethod extends CheckoutEvent {
  final String paymentMethod;

  SelectPaymentMethod({required this.paymentMethod});
}

class ConfirmOrder extends CheckoutEvent {
  final double totalPrice;
  final String address;
  final String paymentType;

  ConfirmOrder(this.totalPrice, this.address, this.paymentType);
}

class GetAllCartItems extends CheckoutEvent {}
