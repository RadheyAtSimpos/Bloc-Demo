abstract class ToDoEvent {}

class AddTaskEvent extends ToDoEvent {
  String strAddTaskValue;

  AddTaskEvent({required this.strAddTaskValue});
}

class UpdateTaskEvent extends ToDoEvent {
  String strUpdateTaskValue;
  int intUpdateTaskIndex;

  UpdateTaskEvent({required this.strUpdateTaskValue, required this.intUpdateTaskIndex});
}

class UpdateTaskIconClickedEvent extends ToDoEvent {
  String strOldValueOfTask;
  int intOldValueIndex;

  UpdateTaskIconClickedEvent({required this.strOldValueOfTask, required this.intOldValueIndex});
}

class RemoveTaskEvent extends ToDoEvent {
  int intRemoveTaskIndex;

  RemoveTaskEvent({required this.intRemoveTaskIndex});
}
