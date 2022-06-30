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
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // loginBloc = BlocProvider.of<LoginBloc>(context);
    ToastContext().init(context);
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: MaterialApp(
          home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<CounterBloc, CounterState>(
                    builder: (context, state) {
                  return Row(
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
                        'Counter value: ${state.intCounterValue}',
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
                  );
                  // color: Colors.greenAccent,
                }),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
