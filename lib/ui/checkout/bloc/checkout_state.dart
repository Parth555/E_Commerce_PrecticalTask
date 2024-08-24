part of 'checkout_bloc.dart';

class CheckoutState extends Equatable{
  final String name;
  final String address;
  final String city;
  final String state;
  final String zip;
  final String paymentMethod;
  final bool isOrderConfirmed;
  final bool isOrderLoading;
  final List<CartItem>? products;
  final double totalPrice;
  final int orderId;
  const CheckoutState( {
    this.name = '',
    this.address = '',
    this.city = '',
    this.state = '',
    this.zip = '',
    this.paymentMethod = '',
    this.products,
    this.totalPrice =0.0,
    this.orderId = 0,
    this.isOrderConfirmed = false,
    this.isOrderLoading = false,
  });

  CheckoutState copyWith({
    String? name,
    String? address,
    String? city,
    String? state,
    String? zip,
    String? paymentMethod,
    List<CartItem>? products,
    double? totalPrice,
    int? orderId,
    bool? isOrderConfirmed,
    bool? isOrderLoading,
  }) {
    return CheckoutState(
      name: name ?? this.name,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      zip: zip ?? this.zip,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      products: products ?? this.products,
      totalPrice: totalPrice ?? this.totalPrice,
      orderId: orderId ?? this.orderId,
      isOrderConfirmed: isOrderConfirmed ?? this.isOrderConfirmed,
      isOrderLoading: isOrderLoading ?? this.isOrderLoading,
    );
  }

  @override
  List<Object?> get props => [name,address,city,state,zip,paymentMethod,isOrderConfirmed,isOrderLoading,products,totalPrice,orderId];
}