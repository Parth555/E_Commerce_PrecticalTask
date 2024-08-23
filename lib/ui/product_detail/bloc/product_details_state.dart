part of 'product_details_bloc.dart';

enum ProductStatus {
  initial,
  productLoading,
  productSuccess,
  productFailure,
  categoryLoading,
  categorySuccess,
  categoryFailure,
}

extension ProductStatusX on ProductStatus {
  bool get isInitial => this == ProductStatus.initial;

  bool get isProductLoading => this == ProductStatus.productLoading;

  bool get isProductSuccess => this == ProductStatus.productSuccess;

  bool get productFailure => this == ProductStatus.productFailure;

  bool get isCategoryLoading => this == ProductStatus.categoryLoading;

  bool get isCategorySuccess => this == ProductStatus.categorySuccess;

  bool get categoryFailure => this == ProductStatus.categoryFailure;
}

class ProductDetailsState extends Equatable {
  const ProductDetailsState({
    this.productStatus = ProductStatus.initial,
    this.errorMessage = '',
    this.product,
    this.categoryStatus = ProductStatus.initial,
    this.products,
    this.itemCount = 1,
    this.selectedColour = 0,
    this.selectedSize = 0,
  });

  final Products? product;
  final ProductStatus productStatus;
  final String errorMessage;

  final List<Products>? products;
  final ProductStatus categoryStatus;

  final int itemCount, selectedColour, selectedSize;

  ProductDetailsState copyWith({
    ProductStatus? productStatus,
    ProductStatus? categoryStatus,
    String? errorMessage,
    Products? product,
    List<Products>? products,
    int? itemCount,int? selectedColour,int? selectedSize
  }) {
    return ProductDetailsState(
      productStatus: productStatus ?? this.productStatus,
      categoryStatus: categoryStatus ?? this.categoryStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      product: product ?? this.product,
      products: products ?? this.products,
      itemCount: itemCount ?? this.itemCount,
      selectedColour: selectedColour ?? this.selectedColour,
      selectedSize: selectedSize ?? this.selectedSize,
    );
  }

  @override
  List<Object?> get props => [productStatus, categoryStatus, errorMessage, product, products,itemCount,selectedColour,selectedSize];
}
