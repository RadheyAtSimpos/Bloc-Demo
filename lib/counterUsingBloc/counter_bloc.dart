import 'package:bloc_demo/counterUsingBloc/counter_event.dart';
import 'package:bloc_demo/counterUsingBloc/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterInitialValueState()) {
    on<CounterIncrementEvent>((event, emit) {
      emit(CounterState(intCounterValue: state.intCounterValue + 1));
    });

    on<CounterDecrementEvent>((event, emit) {
      emit(CounterState(intCounterValue: state.intCounterValue - 1));
    });
  }
}
