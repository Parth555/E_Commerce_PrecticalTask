import 'dart:async';

import 'package:e_commerce/database/cart_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<GetAllCartItems>(_onGrtAllCartItems);
    on<RemoveItemFromCart>(_onRemoveItemFromCart);
  }

  Future<void> _onGrtAllCartItems(
      GetAllCartItems event, Emitter<CartState> emit) async {
    emit(state.copyWith(cartStatus: CartItemsStatus.cartLoading));
    await getAllCartItems(emit);
  }

  getAllCartItems(Emitter<CartState> emit) async {
    List<CartItem> cartItems = objectbox.getCartItems();
    int itemCount = objectbox.getItemCount();
    double totalPrice = cartItems.fold(0.0, (sum, cartItem) {
      double price = cartItem.price!-((cartItem.price!*10)/100); // 10% discount
      return sum + price * cartItem.itemCount!;
    });
    // for(var cartItem in cartItems){
    //   double price = double.parse((cartItem.price!-((cartItem.price!*10)/100)).toStringAsFixed(2));
    //   totalPrice = totalPrice+(price*cartItem.itemCount!);
    // }
    emit(state.copyWith(
        cartStatus: cartItems.isNotEmpty
            ? CartItemsStatus.cartSuccess
            : CartItemsStatus.successWithEmpty,
        products: cartItems,itemCount: itemCount,totalPrice: totalPrice));
  }

  Future<void> _onRemoveItemFromCart(RemoveItemFromCart event, Emitter<CartState> emit) async {
   await objectbox.removeCartItem(event.itemId);
   await getAllCartItems(emit);
  }
}
