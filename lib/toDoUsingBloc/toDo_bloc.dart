import 'package:bloc_demo/toDoUsingBloc/toDo_event.dart';
import 'package:bloc_demo/toDoUsingBloc/toDo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  ToDoBloc() : super(InitialState()) {
    List<String> listAddedTask = [];
    on<AddTaskEvent>((event, emit) {
      listAddedTask.add(event.strAddTaskValue);
      emit(AddTaskToListState(listAddedTask: listAddedTask));
    });

    on<UpdateTaskEvent>((event, emit) {
      listAddedTask.replaceRange(event.intUpdateTaskIndex,
          event.intUpdateTaskIndex + 1, [event.strUpdateTaskValue]);
      emit(UpdateTaskState(strUpdateTaskState: event.strUpdateTaskValue, intUpdateTaskIndex: event.intUpdateTaskIndex));
    });

    on<UpdateTaskIconClickedEvent>((event, emit) {
      emit(UpdateTaskIconClickedState(strOldValueOfTask: event.strOldValueOfTask, intOldValueIndex: event.intOldValueIndex));
    });

    on<RemoveTaskEvent>((event, emit) {
      listAddedTask.removeAt(event.intRemoveTaskIndex);
      emit(RemoveTaskState(intRemoveTaskIndex: event.intRemoveTaskIndex));
    });
  }
}
