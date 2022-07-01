abstract class ToDoState {}

class InitialState extends ToDoState {}

/*class AddTaskState extends ToDoState {
  String strAddTaskState;

  AddTaskState(this.strAddTaskState);
}*/

class AddTaskToListState extends ToDoState {
  var listAddedTask = <String>[];

  AddTaskToListState({required this.listAddedTask});
}

class UpdateTaskState extends ToDoState {
  String strUpdateTaskState;
  int intUpdateTaskIndex;

  UpdateTaskState({required this.strUpdateTaskState, required this.intUpdateTaskIndex});
}

class UpdateTaskIconClickedState extends ToDoState {
  String strOldValueOfTask;
  int intOldValueIndex;

  UpdateTaskIconClickedState({required this.strOldValueOfTask, required this.intOldValueIndex});
}

class RemoveTaskState extends ToDoState {
  int intRemoveTaskIndex;

  RemoveTaskState({required this.intRemoveTaskIndex});
}
