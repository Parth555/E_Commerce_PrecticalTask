part of 'category_products_bloc.dart';

abstract class CategoryProductsEvent extends Equatable{}

class GetAllProduct extends CategoryProductsEvent {
  GetAllProduct(this.category);

  final String category;

  @override
  List<Object?> get props => [category];
}
