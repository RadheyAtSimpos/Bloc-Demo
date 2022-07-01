import 'package:bloc_demo/counterUsingBloc/bloc_observer.dart';
import 'package:bloc_demo/counterUsingBloc/counter_bloc.dart';
import 'package:bloc_demo/counterUsingBloc/counter_event.dart';
import 'package:bloc_demo/counterUsingBloc/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(const ToDoMainScreen()),
    blocObserver: BlocObserverClass(),
  );
}

class ToDoMainScreen extends StatefulWidget {
  const ToDoMainScreen({Key? key}) : super(key: key);

  @override
  ToDoMainScreenState createState() => ToDoMainScreenState();
}

class ToDoMainScreenState extends State<ToDoMainScreen> {

  final controllerArrayValue = TextEditingController();
  var strArrInput = <String>[];

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          backgroundColor: Colors.pink,
          title: const Text(
            "ToDo List",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        body: Column(children: [
          Flexible(
              flex: 10,
              child: ColoredBox(
                  color: Colors.white, child: setupToDoList(context))),
          Flexible(
              flex: 1,
              child: ColoredBox(
                color: Colors.black12,
                child: Row(
                  children: [
                    Flexible(
                        flex: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            cursorColor: Colors.black,
                            // focusNode: focusNodeArrayValue,
                            controller: controllerArrayValue,
                            keyboardType: TextInputType.multiline,
                            style: const TextStyle(
                                fontSize: 14.0, color: Colors.black),
                            decoration: const InputDecoration(
                              hintText: "Please enter value",
                              hintStyle:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                        )),
                    Flexible(
                        flex: 1,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0, 10.0, 10.0, 10.0),
                          child: IconButton(
                            icon: const Icon(Icons.send, color: Colors.pink),
                            onPressed: () async {

                             /* if (controllerArrayValue.text.isNotEmpty) {
                                onAddItemClicked();
                              } else {
                                showToast("Please enter value",
                                    duration: Toast.lengthShort,
                                    gravity: Toast.bottom);
                              }*/
                            },
                          ),
                        ))
                  ],
                ),
              )),
        ]),
      ),
    );
  }

  setupToDoList(BuildContext context) {
    return ListView.builder(
      itemCount: strArrInput.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(7, 3, 7, 2),
          child: Card(
            color: const Color(0xFFFCE4EC),
            shadowColor: Colors.blueGrey,
            child: ListTile(
                onTap: () {},
                title: Text(strArrInput[index],
                    overflow: TextOverflow.ellipsis,
                    style:
                    const TextStyle(fontSize: 18.0, color: Colors.black)),
                trailing: SizedBox(
                    height: 100,
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.black),
                          onPressed: () async {
                            dialogDeleteValue(index, strArrInput[index]);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.black),
                          onPressed: () async {
                            dialogUpdateValue(index, strArrInput[index]);
                          },
                        ),
                      ],
                    ))),
          ),
        );
      },
    );
  }
}
