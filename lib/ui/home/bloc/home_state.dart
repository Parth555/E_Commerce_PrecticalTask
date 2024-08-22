part of 'home_bloc.dart';

enum HomeStatus {
  initial,
  categoryLoading,
  productLoading,
  categorySuccess,
  productSuccess,
  categoryFailure,
  productFailure,
  successWithEmpty
}

extension HomeStatusX on HomeStatus {
  bool get isInitial => this == HomeStatus.initial;

  bool get isCategoryLoading => this == HomeStatus.categoryLoading;

  bool get isProductLoading => this == HomeStatus.productLoading;

  bool get isCategorySuccess => this == HomeStatus.categorySuccess;

  bool get isProductSuccess => this == HomeStatus.productSuccess;

  bool get categoryFailure => this == HomeStatus.categoryFailure;
  bool get productFailure => this == HomeStatus.productFailure;
}

class HomeState extends Equatable {
  const HomeState(
      {this.homeStatus = HomeStatus.initial,
      this.errorMessage = '',
      this.category,
      this.products});

  final List<String>? category;
  final List<Products>? products;
  final HomeStatus homeStatus;
  final String errorMessage;

  HomeState copyWith({
    HomeStatus? homeStatus,
    String? errorMessage,
      List<String>? category,
      List<Products>? products}) {
    return HomeState(
      homeStatus: homeStatus ?? this.homeStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      category: category ?? this.category,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [homeStatus, errorMessage, category, products];
}
