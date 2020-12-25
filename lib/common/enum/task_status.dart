enum TaskStatus{
  done,
  cancel,
  none
}

extension TaskStatusExtension on TaskStatus {
  int get toValue {
    switch (this) {
      case TaskStatus.done:
        return 1;
      case TaskStatus.cancel:
        return 2;
      default:
        return 3;
    }
  }
}

extension TaskStatusValueExtension on num {
  TaskStatus get toTaskStatusType {
    switch (this) {
      case 1:
        return TaskStatus.done;
      case 2:
        return TaskStatus.cancel;
      default:
        return TaskStatus.none;
    }
  }
}