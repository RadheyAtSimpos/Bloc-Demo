import 'package:bloc_demo/toDoUsingBloc/bloc_observer.dart';
import 'package:bloc_demo/toDoUsingBloc/toDo_bloc.dart';
import 'package:bloc_demo/toDoUsingBloc/toDo_event.dart';
import 'package:bloc_demo/toDoUsingBloc/toDo_state.dart';
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
  State<ToDoMainScreen> createState() => ToDoMainScreenState();
}

class ToDoMainScreenState extends State<ToDoMainScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToDoBloc(),
      child: const ToDoTaskScreen(),
    );
  }
}

class ToDoTaskScreen extends StatefulWidget {
  const ToDoTaskScreen({Key? key}) : super(key: key);

  @override
  ToDoTaskScreenState createState() => ToDoTaskScreenState();
}

class ToDoTaskScreenState extends State<ToDoTaskScreen> {
  var controllerTaskValue = TextEditingController();
  final controllerUpdateTaskValue = TextEditingController();
  List<String> listAddedTasks = [];
  var isSendUpdateEvent = false;

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
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
                    BlocBuilder<ToDoBloc, ToDoState>(builder: (context, state) {
                      if (state is UpdateTaskIconClickedState) {
                        controllerTaskValue = TextEditingController(
                            text: state.strOldValueOfTask);
                      }
                      return Flexible(
                        flex: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            cursorColor: Colors.black,
                            controller: controllerTaskValue,
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
                        ),
                      );
                    }),
                    BlocBuilder<ToDoBloc, ToDoState>(builder: (context, state) {
                      int intOldValueIndex;
                      if (state is UpdateTaskIconClickedState) {
                        isSendUpdateEvent = true;
                        intOldValueIndex = state.intOldValueIndex;
                        print('its UpdateTaskIconClickedState');
                      } else {
                        isSendUpdateEvent = false;
                        intOldValueIndex = 0;
                        print('its Not UpdateTaskIconClickedState');
                      }
                      return Flexible(
                        flex: 1,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0, 10.0, 10.0, 10.0),
                          child: IconButton(
                            icon: const Icon(Icons.send, color: Colors.pink),
                            onPressed: () async {
                              if (isSendUpdateEvent) {
                                if (controllerTaskValue.text.isNotEmpty) {
                                  BlocProvider.of<ToDoBloc>(context).add(UpdateTaskEvent(
                                      strUpdateTaskValue:
                                      controllerTaskValue.text.toString(),
                                      intUpdateTaskIndex: intOldValueIndex));
                                  controllerTaskValue.clear();
                                } else {
                                  print('Please enter value');
                                }
                              } else {
                                if (controllerTaskValue.text.isNotEmpty) {
                                  BlocProvider.of<ToDoBloc>(context).add(
                                      AddTaskEvent(
                                          strAddTaskValue:
                                              controllerTaskValue.text));
                                  controllerTaskValue.clear();
                                } else {
                                  print('Please enter value');
                                }
                              }
                            },
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              )),
        ]),
      ),
    );
  }

  setupToDoList(BuildContext context) {
    return BlocBuilder<ToDoBloc, ToDoState>(builder: (context, state) {
      if (state is AddTaskToListState) {
        listAddedTasks = state.listAddedTask;
        print('Add task performed');
      }

      if (state is UpdateTaskState) {
        print(
            'Update value is: ${state.strUpdateTaskState} and index is: ${state.intUpdateTaskIndex}');
      }

      return ListView.builder(
        itemCount: listAddedTasks.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(7, 3, 7, 2),
            child: Card(
              color: const Color(0xFFFCE4EC),
              shadowColor: Colors.blueGrey,
              child: ListTile(
                  onTap: () {},
                  title: Text(listAddedTasks[index],
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
                              BlocProvider.of<ToDoBloc>(context).add(
                                  RemoveTaskEvent(intRemoveTaskIndex: index));
                              setState(() {});
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.black),
                            onPressed: () async {
                              BlocProvider.of<ToDoBloc>(context).add(
                                  UpdateTaskIconClickedEvent(
                                      strOldValueOfTask:
                                          listAddedTasks[index], intOldValueIndex: index));

                              /*showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Are you sure you want to edit " + listAddedTasks[index] + "?",
                                        style: const TextStyle(fontSize: 16.0)),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('CANCEL',
                                            style: TextStyle(fontSize: 16.0, color: Colors.black)),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          if (controllerUpdateTaskValue.text.isNotEmpty) {
                                            BlocProvider.of<ToDoBloc>(context).add(UpdateTaskEvent(
                                                strUpdateTaskValue:
                                                controllerUpdateTaskValue.text.toString(),
                                                intUpdateTaskIndex: index));
                                            Navigator.pop(context);
                                          } else {
                                            print("Please enter value");
                                          }
                                        },
                                        child: const Text('YES',
                                            style: TextStyle(fontSize: 16.0, color: Colors.black)),
                                      ),
                                    ],
                                    content: TextField(
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.multiline,
                                      // focusNode: focusNodeUpdateValue,
                                      controller: controllerUpdateTaskValue..text = listAddedTasks[index],
                                      style: const TextStyle(fontSize: 14.0, color: Colors.black),
                                      decoration: const InputDecoration(
                                        hintText: "Please enter new value",
                                        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                              // dialogUpdateValue(index, listAddedTasks[index]);*/
                            },
                          ),
                        ],
                      ))),
            ),
          );
        },
      );
    });
  }
}
