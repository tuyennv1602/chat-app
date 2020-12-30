import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chat_app/common/blocs/loading_bloc/loading_bloc.dart';
import 'package:chat_app/common/blocs/loading_bloc/loading_event.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/exception/network_exception.dart';
import 'package:chat_app/common/extensions/dio_ext.dart';
import 'package:chat_app/data/models/request/create_task_request_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:meta/meta.dart';

part 'create_task_event.dart';

part 'create_task_state.dart';

class CreateTaskBloc extends Bloc<CreateTaskEvent, CreateTaskState> {
  LoadingBloc loadingBloc;

  CreateTaskBloc() : super(CreateTaskInitial());

  @override
  Stream<CreateTaskState> mapEventToState(CreateTaskEvent event,) async* {
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
      ..listSelectedMemberId = event.listSelectedMemberId ?? state.createTaskRequestModel.listSelectedMemberId
      ..createDate = event.createDate ?? state.createTaskRequestModel.createDate
      ..finishDate = event.finishDate ?? state.createTaskRequestModel.finishDate
      ..priorityId = event.priorityId ?? state.createTaskRequestModel.priorityId
      ..taskTitle = event.taskTitle ?? state.createTaskRequestModel.taskTitle
      ..taskContent = event.taskContent ?? state.createTaskRequestModel.taskContent;

    final _enableButton = state.createTaskRequestModel.taskTitle.isNotEmpty && state.createTaskRequestModel.taskContent.isNotEmpty && state.createTaskRequestModel.createDate.isBefore(state.createTaskRequestModel.finishDate) && state.createTaskRequestModel.listSelectedMemberId.isNotEmpty;

    if (_enableButton != state.enableButton) {
      yield ValidateCreateTaskState(state, enableButton: _enableButton);
    }
  }

  Stream<CreateTaskState> _onSubmitCreateTask(OnSubmitCreateTaskEvent event) async* {
    try {
      yield CreatingTaskState(state);

      /// TO DO

      yield CreateTaskSuccessState(state);
    } on DioError catch (e) {
      yield* _handleError(e.errorMessage);
    } on NetworkException catch (e) {
      yield* _handleError(e.message);
    } catch (e) {
      yield* _handleError(translate(StringConst.unknowError));
    }
  }

  Stream<CreateTaskState> _handleError(String message) async* {
    loadingBloc.add(FinishLoading());
    yield CreateTaskErrorState(
        message,
        state
    );
  }
}
