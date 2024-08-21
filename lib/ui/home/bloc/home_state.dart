part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({this.value = 0, this.height = 80, this.isFullImage = false});

  final int value;
  final double height;
  final bool isFullImage;

  HomeState copyWith({int? count, double? height}) {
    return HomeState(value: count ?? this.value, height: height ?? this.height, isFullImage: !((height ?? this.height) == 80));
  }

  @override
  List<Object?> get props => [value, height, isFullImage];
}
