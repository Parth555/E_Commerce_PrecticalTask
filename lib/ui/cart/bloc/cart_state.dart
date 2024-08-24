part of 'cart_bloc.dart';

enum CartItemsStatus {
  initial,
  cartLoading,
  cartSuccess,
  cartFailure,
  successWithEmpty
}

extension CartItemsStatusX on CartItemsStatus {
  bool get isInitial => this == CartItemsStatus.initial;

  bool get isCartLoading => this == CartItemsStatus.cartLoading;

  bool get isCartSuccess => this == CartItemsStatus.cartSuccess;

  bool get cartFailure => this == CartItemsStatus.cartFailure;

  bool get cartSuccessWithEmpty => this == CartItemsStatus.successWithEmpty;
}

class CartState extends Equatable {
  const CartState(
      {this.cartStatus = CartItemsStatus.initial,
      this.errorMessage = '',
      this.itemCount = 0,
      this.totalPrice = 0.0,
      this.products});

  final List<CartItem>? products;
  final CartItemsStatus cartStatus;
  final String errorMessage;
  final int itemCount;
  final double totalPrice;

  CartState copyWith({
    List<CartItem>? products,
    CartItemsStatus? cartStatus,
    String? errorMessage,
    int? itemCount,
    double? totalPrice
  }) {
    return CartState(
      products: products ?? this.products,
      cartStatus: cartStatus ?? this.cartStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      itemCount: itemCount ?? this.itemCount,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  @override
  List<Object?> get props => [products, cartStatus, errorMessage,itemCount,totalPrice];
}
