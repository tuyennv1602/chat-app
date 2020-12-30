import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chat_app/common/blocs/loading_bloc/loading_bloc.dart';
import 'package:chat_app/common/blocs/loading_bloc/loading_event.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/exception/network_exception.dart';
import 'package:chat_app/domain/entities/task_entity.dart';
import 'package:chat_app/domain/usecases/task_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:meta/meta.dart';
import 'package:chat_app/common/extensions/dio_ext.dart';

part 'task_detail_event.dart';

part 'task_detail_state.dart';

class TaskDetailBloc extends Bloc<TaskDetailEvent, TaskDetailState> {
  final LoadingBloc loadingBloc;
  final TaskUseCase taskUseCase;

  TaskDetailBloc({this.loadingBloc, this.taskUseCase}) : super(TaskDetailInitial());

  @override
  Stream<TaskDetailState> mapEventToState(TaskDetailEvent event) async* {
    switch (event.runtimeType) {
      case OnGetTaskDetailEvent:
        yield* _mapGetTaskDetailToState(event);
        break;
      default:
    }
  }

  Stream<TaskDetailState> _mapGetTaskDetailToState(OnGetTaskDetailEvent event) async* {
    try {
      yield LoadingTaskDetailState();
      final task = await taskUseCase.getTaskDetail(event.taskId);
      yield LoadedTaskDetailState(task: task);
    } on DioError catch (e) {
      yield* _handleError(e.errorMessage);
    } on NetworkException catch (e) {
      yield* _handleError(e.message);
    } catch (e) {
      yield* _handleError(translate(StringConst.unknowError));
    }
  }

  Stream<TaskDetailState> _handleError(String message) async* {
    loadingBloc.add(FinishLoading());
    yield ErrorLoadTaskDetailState(
      message,
      task: state.task,
    );
  }
}
