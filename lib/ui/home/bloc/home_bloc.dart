import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<Increment>((event, emit) {
      emit(state.copyWith(count: state.value + 1));
    });
    on<Decrement>((event, emit) {
      emit(state.copyWith(count: state.value - 1));
    });
    on<AnimationChange>((event, emit) {
      emit(state.copyWith(
        height: event.height,
      ));
    });
  }
}
