part of 'create_task_bloc.dart';

@immutable
abstract class CreateTaskEvent {}

class OnValidateCreateTaskEvent extends CreateTaskEvent {
  final List<int> listSelectedMemberId;
  final DateTime createDate;
  final DateTime finishDate;
  final int priorityId;
  final bool enableButton;
  final String taskTitle, taskContent;
  final int roomId;
  final int leaderId;

  OnValidateCreateTaskEvent( {
    this.listSelectedMemberId,
    this.createDate,
    this.finishDate,
    this.priorityId,
    this.enableButton,
    this.taskTitle,
    this.taskContent,
    this.roomId, this.leaderId,
  });
}

class OnSubmitCreateTaskEvent extends CreateTaskEvent{}
