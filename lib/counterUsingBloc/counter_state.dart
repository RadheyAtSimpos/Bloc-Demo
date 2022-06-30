import 'package:equatable/equatable.dart';

 class CounterState extends Equatable {
  final int intCounterValue;

  const CounterState({required this.intCounterValue});

  @override
  // TODO: implement props
  List<Object?> get props => [intCounterValue];
}

class CounterInitialValueState extends CounterState {
  const CounterInitialValueState() : super(intCounterValue: 0);
}
