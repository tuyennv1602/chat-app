import 'package:chat_app/common/blocs/loading_bloc/loading_bloc.dart';
import 'package:chat_app/common/blocs/loading_bloc/loading_event.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/exception/network_exception.dart';
import 'package:chat_app/domain/usecases/room_usecase.dart';
import 'package:chat_app/presentation/features/home/bloc/create_room_bloc/create_room_event.dart';
import 'package:chat_app/presentation/features/home/bloc/create_room_bloc/create_room_state.dart';
import 'package:chat_app/presentation/features/home/bloc/room_bloc/room_bloc.dart';
import 'package:chat_app/presentation/features/home/bloc/room_bloc/room_event.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/global.dart';
import 'package:chat_app/common/extensions/dio_ext.dart';

class CreateRoomBloc extends Bloc<CreateRoomEvent, CreateRoomState> {
  final RoomUseCase roomUseCase;
  final LoadingBloc loadingBloc;
  final RoomBloc roomBloc;

  CreateRoomBloc({
    this.roomBloc,
    this.loadingBloc,
    this.roomUseCase,
  }) : super(InitialCreateRoomState());

  @override
  Stream<CreateRoomState> mapEventToState(CreateRoomEvent event) async* {
    try {
      loadingBloc.add(StartLoading());
      final memberIds = event.members.map((mem) => mem.code).toList();
      await roomUseCase.createRoom(event.roomName, memberIds);
      roomBloc.add(RefreshRoomEvent());
      loadingBloc.add(FinishLoading());
      yield CreatedRoomSuccessState();
    } on DioError catch (e) {
      yield* _handleError(e.errorMessage);
    } on NetworkException catch (e) {
      yield* _handleError(e.message);
    } catch (e) {
      yield* _handleError(translate(StringConst.unknowError));
    }
  }

  Stream<CreateRoomState> _handleError(String message) async* {
    loadingBloc.add(FinishLoading());
    yield ErroredCreateRoomState(message);
  }
}
