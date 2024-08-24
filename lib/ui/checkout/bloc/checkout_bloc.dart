
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../database/cart_model.dart';
import '../../../main.dart';
import '../../../utils/debug.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(const CheckoutState()) {
    on<GetAllCartItems>(_onGrtAllCartItems);
    on<UpdateShippingInformation>((event, emit) {
      emit(state.copyWith(
        name: event.name,
        address: event.address,
        city: event.city,
        state: event.state,
        zip: event.zip,
      ));
    });

    on<SelectPaymentMethod>((event, emit) {
      emit(state.copyWith(paymentMethod: event.paymentMethod));
    });

    on<ConfirmOrder>((event, emit) async {
      emit(state.copyWith(isOrderLoading: true));
      objectbox.addOrder(event.totalPrice);
      await Future.delayed(const Duration(seconds: 2));
      int orderCount = objectbox.getOrderCount();
      Debug.printLog('orderCount :$orderCount');
      objectbox.updateCartItems(orderCount);
      emit(state.copyWith(isOrderConfirmed: true,isOrderLoading: false,orderId: orderCount));
    });
  }

  FutureOr<void> _onGrtAllCartItems(GetAllCartItems event, Emitter<CheckoutState> emit) {
    List<CartItem> cartItems = objectbox.getCartItems();
    double totalPrice = cartItems.fold(0.0, (sum, cartItem) {
      double price = cartItem.price!-((cartItem.price!*10)/100); // 10% discount
      return sum + price * cartItem.itemCount!;
    });
    // for(var cartItem in cartItems){
    //   double price = double.parse((cartItem.price!-((cartItem.price!*10)/100)).toStringAsFixed(2));
    //   totalPrice = totalPrice+(price*cartItem.itemCount!);
    // }
    emit(state.copyWith(products: cartItems,totalPrice: totalPrice));
  }
}