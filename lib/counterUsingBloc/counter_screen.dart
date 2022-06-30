import 'package:bloc_demo/counterUsingBloc/bloc_observer.dart';
import 'package:bloc_demo/counterUsingBloc/counter_bloc.dart';
import 'package:bloc_demo/counterUsingBloc/counter_event.dart';
import 'package:bloc_demo/counterUsingBloc/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(const CounterScreen()),
    blocObserver: BlocObserverClass(),
  );
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  CounterScreenState createState() => CounterScreenState();
}

class CounterScreenState extends State<CounterScreen> {
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: const IncDecClass(),
    );
  }
}

class IncDecClass extends StatefulWidget {
  const IncDecClass({Key? key}) : super(key: key);

  @override
  State<IncDecClass> createState() => _IncDecClassState();
}

class _IncDecClassState extends State<IncDecClass> {
  late int intCounterValues;

  @override
  void initState() {
    intCounterValues = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocListener<CounterBloc, CounterState>(
                  listener: (context, state) {
                    intCounterValues = state.intCounterValue;
                    setState(() {});
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MaterialButton(
                        color: Colors.orange,
                        child: const Text('Increment'),
                        onPressed: () {
                          context
                              .read<CounterBloc>()
                              .add(CounterIncrementEvent());
                        },
                      ),
                      Text(
                        'Counter value: $intCounterValues',
                        style: const TextStyle(fontSize: 16),
                      ),
                      MaterialButton(
                        color: Colors.orange,
                        child: const Text('Decrement'),
                        onPressed: () {
                          context
                              .read<CounterBloc>()
                              .add(CounterDecrementEvent());
                        },
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    ));
  }
}
