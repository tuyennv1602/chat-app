enum TaskPriority{
  high,
  medium,
  none
}

extension TaskPriorityExtension on TaskPriority {
  String get toValue {
    switch (this) {
      case TaskPriority.high:
        return 'Cao';
      case TaskPriority.medium:
        return 'Trung bình';
      default:
        return 'Thấp';
    }
  }
}

extension TaskPriorityValueExtension on String {
  TaskPriority get toTaskPriorityType {
    switch (this) {
      case 'Cao':
        return TaskPriority.high;
      case 'Trung bình':
        return TaskPriority.medium;
      default:
        return TaskPriority.none;
    }
  }
}