import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chat_app/common/blocs/loading_bloc/loading_bloc.dart';
import 'package:chat_app/common/blocs/loading_bloc/loading_event.dart';
import 'package:chat_app/common/utils/error_utils.dart';
import 'package:chat_app/data/models/request/create_task_request_model.dart';
import 'package:chat_app/domain/usecases/task_usecase.dart';
import 'package:meta/meta.dart';

part 'create_task_event.dart';

part 'create_task_state.dart';

class CreateTaskBloc extends Bloc<CreateTaskEvent, CreateTaskState> {
  final LoadingBloc loadingBloc;
  final TaskUseCase taskUseCase;

  CreateTaskBloc(this.loadingBloc, this.taskUseCase) : super(CreateTaskInitial());

  @override
  Stream<CreateTaskState> mapEventToState(
    CreateTaskEvent event,
  ) async* {
    switch (event.runtimeType) {
      case OnValidateCreateTaskEvent:
        yield* _onValidateCreateTask(event);
        break;
      case OnSubmitCreateTaskEvent:
        yield* _onSubmitCreateTask(event);
        break;
      default:
    }
  }

  Stream<CreateTaskState> _onValidateCreateTask(OnValidateCreateTaskEvent event) async* {
    state.createTaskRequestModel
      ..listSelectedMemberId =
          event.listSelectedMemberId ?? state.createTaskRequestModel.listSelectedMemberId
      ..createDate = event.createDate ?? state.createTaskRequestModel.createDate
      ..finishDate = event.finishDate ?? state.createTaskRequestModel.finishDate
      ..priorityId = event.priorityId ?? state.createTaskRequestModel.priorityId
      ..taskTitle = event.taskTitle ?? state.createTaskRequestModel.taskTitle
      ..taskContent = event.taskContent ?? state.createTaskRequestModel.taskContent
      ..roomId = event.roomId ?? state.createTaskRequestModel.roomId
      ..createBy = event.leaderId ?? state.createTaskRequestModel.createBy;

    final _enableButton = state.createTaskRequestModel.taskTitle.isNotEmpty &&
        state.createTaskRequestModel.taskContent.isNotEmpty &&
        state.createTaskRequestModel.createDate.isBefore(state.createTaskRequestModel.finishDate) &&
        state.createTaskRequestModel.listSelectedMemberId.isNotEmpty;

    if (_enableButton != state.enableButton) {
      yield ValidateCreateTaskState(state, enableButton: _enableButton);
    }
  }

  Stream<CreateTaskState> _onSubmitCreateTask(OnSubmitCreateTaskEvent event) async* {
    try {
      yield CreatingTaskState(state);
      await taskUseCase.createTask(state.createTaskRequestModel);
      yield CreateTaskSuccessState(state);
    } catch (e) {
      loadingBloc.add(FinishLoading());
      yield CreateTaskErrorState(ErrorUtils.parseError(e), state);
    }
  }
}
