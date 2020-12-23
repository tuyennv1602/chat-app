import 'package:chat_app/common/blocs/loading_bloc/loading_bloc.dart';
import 'package:chat_app/common/blocs/loading_bloc/loading_event.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/exception/network_exception.dart';
import 'package:chat_app/domain/usecases/room_usecase.dart';
import 'package:chat_app/presentation/features/conversation/bloc/option_bloc/option_event.dart';
import 'package:chat_app/presentation/features/conversation/bloc/option_bloc/option_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/common/extensions/dio_ext.dart';
import 'package:flutter_translate/global.dart';

class OptionBloc extends Bloc<OptionEvent, OptionState> {
  final LoadingBloc loadingBloc;
  final RoomUseCase roomUseCase;

  OptionBloc({
    this.loadingBloc,
    this.roomUseCase,
  }) : super(InitialOptionState());

  @override
  Stream<OptionState> mapEventToState(OptionEvent event) async* {
    switch (event.runtimeType) {
      case GetJoinCodeEvent:
        yield* _mapGetJoinRoomCode(event);
        break;
      default:
    }
  }

  Stream<OptionState> _mapGetJoinRoomCode(GetJoinCodeEvent event) async* {
    try {
      loadingBloc.add(StartLoading());
      final resp = await roomUseCase.getJoinCode(event.roomId);
      loadingBloc.add(FinishLoading());
      yield LoadedJoinCodeOptionState(resp.roomCode);
    } on DioError catch (e) {
      yield* _handleError(e.errorMessage);
    } on NetworkException catch (e) {
      yield* _handleError(e.message);
    } catch (e) {
      yield* _handleError(translate(StringConst.unknowError));
    }
  }

  Stream<OptionState> _handleError(String message) async* {
    loadingBloc.add(FinishLoading());
    yield ErroredOptionState(message);
  }
}
