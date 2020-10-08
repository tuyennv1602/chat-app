enum TaskStatus {
  none,
  done,
  cancel,
}

class TaskEntity {
  static TaskStatus checkTaskStatus(int status) {
    switch (status) {
      case 0:
        return TaskStatus.none;
      case 1:
        return TaskStatus.done;
      default:
        return TaskStatus.cancel;
    }
  }
}
