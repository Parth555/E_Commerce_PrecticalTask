part of 'home_bloc.dart';

enum HomeStatus { initial, categoryLoading, productLoading, categorySuccess, productSuccess, failure, successWithEmpty }

extension HomeStatusX on HomeStatus {
  bool get isInitial => this == HomeStatus.initial;

  bool get isCategoryLoading => this == HomeStatus.categoryLoading;

  bool get isProductLoading => this == HomeStatus.productLoading;

  bool get isCategorySuccess => this == HomeStatus.categorySuccess;

  bool get isProductSuccess => this == HomeStatus.productSuccess;

  bool get isFailure => this == HomeStatus.failure;
}

class HomeState extends Equatable {
  const HomeState({this.value = 0, this.height = 80, this.isFullImage = false});

  final List<String> category;
  final int value;
  final double height;
  final bool isFullImage;

  HomeState copyWith({int? count, double? height}) {
    return HomeState(value: count ?? value, height: height ?? this.height, isFullImage: !((height ?? this.height) == 80));
  }

  @override
  List<Object?> get props => [value, height, isFullImage];
}
