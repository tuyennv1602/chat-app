part of 'task_detail_bloc.dart';
@immutable
abstract class TaskDetailEvent {}
class OnGetTaskDetailEvent extends TaskDetailEvent{
  final int taskId;

  OnGetTaskDetailEvent({this.taskId});
}
