part of 'product_details_bloc.dart';

abstract class ProductDetailsEvent extends Equatable {}

class GetProductDetail extends ProductDetailsEvent {
  GetProductDetail(this.productId,this.context);

  final int productId;
  final BuildContext context;

  @override
  List<Object?> get props => [productId];
}

class GetAllProduct extends ProductDetailsEvent {
  GetAllProduct(this.productId,this.category);

  final String category;
  final int productId;

  @override
  List<Object?> get props => [productId,category];
}

class IncrementItem extends ProductDetailsEvent {
  IncrementItem(this.itemCount);

  final int itemCount;

  @override
  List<Object?> get props => [itemCount];
}
class DecrementItem extends ProductDetailsEvent {
  DecrementItem(this.itemCount);

  final int itemCount;

  @override
  List<Object?> get props => [itemCount];
}
class SelectedColour extends ProductDetailsEvent {
  SelectedColour(this.itemIndex);

  final int itemIndex;

  @override
  List<Object?> get props => [itemIndex];
}

class SelectedSizeIndex extends ProductDetailsEvent {
  SelectedSizeIndex(this.itemIndex);

  final int itemIndex;

  @override
  List<Object?> get props => [itemIndex];
}


class ItemAddToCart extends ProductDetailsEvent {
  ItemAddToCart(this.product);

  final Products product;

  @override
  List<Object?> get props => [product];
}


