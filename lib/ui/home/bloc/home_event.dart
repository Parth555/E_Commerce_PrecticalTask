part of 'home_bloc.dart';

abstract class HomeEvent {}

class Increment extends HomeEvent {}

class Decrement extends HomeEvent {}

class ToggleImageView extends HomeEvent {}

class AnimationChange extends HomeEvent {
  AnimationChange({this.height = 80});
  double height;
}
