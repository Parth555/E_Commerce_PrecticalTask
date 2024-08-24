part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable{}

class GetAllCartItems extends CartEvent {
  @override
  List<Object?> get props => [];
}

class RemoveItemFromCart extends CartEvent {
  RemoveItemFromCart(this.itemId);

  final int itemId;

  @override
  List<Object?> get props => [itemId];
}