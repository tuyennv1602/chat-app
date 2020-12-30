part of 'task_detail_bloc.dart';

@immutable
abstract class TaskDetailState {
  final TaskEntity task;

  TaskDetailState({
    this.task,
  });
}

class TaskDetailInitial extends TaskDetailState {}

class LoadingTaskDetailState extends TaskDetailState {
  LoadingTaskDetailState() : super(task: TaskEntity());
}

class LoadedTaskDetailState extends TaskDetailState {
  LoadedTaskDetailState({
    TaskEntity task,
  }) : super(
          task: task,
        );
}

class ErrorLoadTaskDetailState extends TaskDetailState {
  final String error;

  ErrorLoadTaskDetailState(
    this.error, {
    TaskEntity task,
  }) : super(task: task);
}
