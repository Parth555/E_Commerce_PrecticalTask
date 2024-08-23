part of 'category_products_bloc.dart';

enum CategoryStatus {
  initial,
  categoryLoading,
  categorySuccess,
  categoryFailure,
}

extension CategoryStatusX on CategoryStatus {
  bool get isInitial => this == CategoryStatus.initial;

  bool get isCategoryLoading => this == CategoryStatus.categoryLoading;

  bool get isCategorySuccess => this == CategoryStatus.categorySuccess;

  bool get categoryFailure => this == CategoryStatus.categoryFailure;
}


class CategoryProductsState extends Equatable {
  const CategoryProductsState({
    this.categoryStatus = CategoryStatus.initial,
    this.errorMessage = '',
    this.products,
  });


  final List<Products>? products;
  final CategoryStatus categoryStatus;
  final String errorMessage;

  CategoryProductsState copyWith({
    CategoryStatus? categoryStatus,
    String? errorMessage,
    List<String>? category,
    List<Products>? products}) {
    return CategoryProductsState(
      categoryStatus: categoryStatus ?? this.categoryStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [categoryStatus, errorMessage,products];
}

