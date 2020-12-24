part of 'task_list_bloc.dart';
@immutable
abstract class TaskListEvent {}
class OnGetAllTasksEvent extends TaskListEvent{
  final int roomId;

  OnGetAllTasksEvent({this.roomId});
}
