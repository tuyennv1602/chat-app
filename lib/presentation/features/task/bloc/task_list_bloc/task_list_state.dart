part of 'task_list_bloc.dart';
@immutable
abstract class TaskListState {
  final List<TaskEntity> tasks;
  final bool canLoadMore;
  final int page;

  TaskListState({
    this.tasks,
    this.canLoadMore = false,
    this.page = 1,
  });
}
class TaskListInitial extends TaskListState {}


class LoadingTasksState extends TaskListState {
  LoadingTasksState() : super(tasks: []);
}

class LoadingMoreTasksState extends TaskListState {
  LoadingMoreTasksState({List<TaskEntity> tasks}) : super(tasks: tasks);
}

class RefreshingTasksState extends TaskListState {
  RefreshingTasksState({List<TaskEntity> tasks}) : super(tasks: tasks);
}

class LoadedTasksState extends TaskListState {
  LoadedTasksState({
    List<TaskEntity> tasks,
    bool canLoadMore,
    int page,
  }) : super(
    tasks: tasks,
    canLoadMore: canLoadMore,
    page: page,
  );
}

class ErrorLoadTasksState extends TaskListState {
  final String error;
  ErrorLoadTasksState(
      this.error, {
        List<TaskEntity> tasks,
        bool canLoadMore,
        int page,
      }) : super(tasks: tasks, canLoadMore: canLoadMore, page: page);
}