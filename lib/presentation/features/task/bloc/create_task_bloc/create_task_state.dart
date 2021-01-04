part of 'create_task_bloc.dart';

@immutable
abstract class CreateTaskState {
  final bool enableButton;

  // final List<int> listSelectedMemberId;
  // final DateTime createDate;
  // final DateTime finishDate;
  // final int priorityId;
  // final String taskTitle;
  // final String taskContent;
  final CreateTaskRequestModel createTaskRequestModel;

  CreateTaskState({
    // this.createDate,
    // this.finishDate,
    // this.listSelectedMemberId,
    // this.priorityId,
    // this.taskTitle,
    // this.taskContent,
    this.createTaskRequestModel,
    this.enableButton,
  });
}

class CreateTaskInitial extends CreateTaskState {
  CreateTaskInitial()
      : super(
          enableButton: false,
          createTaskRequestModel: CreateTaskRequestModel(),
        );
}

class ValidateCreateTaskState extends CreateTaskState {
  ValidateCreateTaskState(
    CreateTaskState state, {
    bool enableButton,
  }) : super(
          enableButton: enableButton ?? state.enableButton,
          createTaskRequestModel: state.createTaskRequestModel,
        );
}

class CreatingTaskState extends CreateTaskState {
  CreatingTaskState(
    CreateTaskState state,
  ) : super(
          enableButton: state.enableButton,
          createTaskRequestModel: state.createTaskRequestModel,
        );
}

class CreateTaskSuccessState extends CreateTaskState {
  CreateTaskSuccessState(
    CreateTaskState state,
  ) : super(
          enableButton: state.enableButton,
          createTaskRequestModel: state.createTaskRequestModel,
        );
}

class CreateTaskErrorState extends CreateTaskState {
  final String error;

  CreateTaskErrorState(
    this.error,
    CreateTaskState state,
  ) : super(
          enableButton: state.enableButton,
          createTaskRequestModel: state.createTaskRequestModel,
        );
}
