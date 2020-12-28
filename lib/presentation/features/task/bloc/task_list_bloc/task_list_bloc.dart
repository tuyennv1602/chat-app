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

part 'task_list_event.dart';
part 'task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final LoadingBloc loadingBloc;
  final TaskUseCase taskUseCase;

  TaskListBloc({this.loadingBloc, this.taskUseCase}) : super(TaskListInitial());

  @override
  Stream<TaskListState> mapEventToState(TaskListEvent event) async* {
    switch (event.runtimeType) {
      case OnGetAllTasksEvent:
        yield* _mapGetTasksToState(event);
        break;
      default:
    }
  }

  Stream<TaskListState> _mapGetTasksToState(OnGetAllTasksEvent event) async* {
    try {
      yield LoadingTasksState();
      final data = await taskUseCase.loadTasks(event.roomId);
      yield LoadedTasksState(tasks: data.tasks);
    } on DioError catch (e) {
      yield* _handleError(e.errorMessage);
    } on NetworkException catch (e) {
      yield* _handleError(e.message);
    } catch (e) {
      yield* _handleError(translate(StringConst.unknowError));
    }
  }

  Stream<TaskListState> _handleError(String message) async* {
    loadingBloc.add(FinishLoading());
    yield ErrorLoadTasksState(
      message,
      tasks: state.tasks,
    );
  }
}
