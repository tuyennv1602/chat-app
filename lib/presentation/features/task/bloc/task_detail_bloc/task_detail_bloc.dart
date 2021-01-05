import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chat_app/common/blocs/loading_bloc/loading_bloc.dart';
import 'package:chat_app/common/blocs/loading_bloc/loading_event.dart';
import 'package:chat_app/common/utils/error_utils.dart';
import 'package:chat_app/domain/entities/task_entity.dart';
import 'package:chat_app/domain/usecases/task_usecase.dart';
import 'package:meta/meta.dart';

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
    } catch (e) {
      loadingBloc.add(FinishLoading());
      yield ErrorLoadTaskDetailState(
        ErrorUtils.parseError(e),
        task: state.task,
      );
    }
  }
}
