import 'package:chat_app/common/blocs/loading_bloc/loading_bloc.dart';
import 'package:chat_app/common/blocs/loading_bloc/loading_event.dart';
import 'package:chat_app/common/utils/error_utils.dart';
import 'package:chat_app/domain/usecases/room_usecase.dart';
import 'package:chat_app/presentation/features/home/bloc/room_bloc/room_event.dart';
import 'package:chat_app/presentation/features/home/bloc/room_bloc/room_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final RoomUseCase roomUseCase;
  final LoadingBloc loadingBloc;

  RoomBloc({
    this.roomUseCase,
    this.loadingBloc,
  }) : super(InitialRoomState());

  @override
  Stream<RoomState> mapEventToState(RoomEvent event) async* {
    switch (event.runtimeType) {
      case LoadRoomEvent:
        yield* _mapLoadRoomToState(event);
        break;
      case RefreshRoomEvent:
        yield* _mapRefreshRoomToState(event);
        break;
      case LoadMoreRoomEvent:
        yield* _mapLoadMoreRoomToState(event);
        break;
      case RequestJoinRoomEvent:
        yield* _mapRequestJoinToState(event);
        break;
      default:
    }
  }

  Stream<RoomState> _mapLoadRoomToState(LoadRoomEvent event) async* {
    try {
      yield LoadingRoomState();
      final resp = await roomUseCase.loadRooms(1);
      yield LoadedRoomState(
        rooms: resp.rooms,
        canLoadMore: resp.hasNext,
        page: resp.page,
      );
    } catch (e) {
      loadingBloc.add(FinishLoading());
      yield ErrorLoadRoomState(
        ErrorUtils.parseError(e),
        rooms: state.rooms,
        page: state.page,
        canLoadMore: state.canLoadMore,
      );
    }
  }

  Stream<RoomState> _mapRefreshRoomToState(RefreshRoomEvent event) async* {
    try {
      yield RefreshingRoomState(rooms: state.rooms);
      final resp = await roomUseCase.loadRooms(1);
      yield LoadedRoomState(
        rooms: resp.rooms,
        canLoadMore: resp.hasNext,
        page: resp.page,
      );
    } catch (e) {
      loadingBloc.add(FinishLoading());
      yield ErrorLoadRoomState(
        ErrorUtils.parseError(e),
        rooms: state.rooms,
        page: state.page,
        canLoadMore: state.canLoadMore,
      );
    }
  }

  Stream<RoomState> _mapLoadMoreRoomToState(LoadMoreRoomEvent event) async* {
    try {
      yield LoadingMoreRoomState(rooms: state.rooms);
      final resp = await roomUseCase.loadRooms(state.page + 1);
      yield LoadedRoomState(
        rooms: state.rooms..addAll(resp.rooms),
        canLoadMore: resp.hasNext,
        page: resp.page,
      );
    } catch (e) {
      loadingBloc.add(FinishLoading());
      yield ErrorLoadRoomState(
        ErrorUtils.parseError(e),
        rooms: state.rooms,
        page: state.page,
        canLoadMore: state.canLoadMore,
      );
    }
  }

  Stream<RoomState> _mapRequestJoinToState(RequestJoinRoomEvent event) async* {
    try {
      loadingBloc.add(StartLoading());
      await roomUseCase.joinRoom(event.joinCode);
      final resp = await roomUseCase.loadRooms(1);
      loadingBloc.add(FinishLoading());
      yield LoadedRoomState(
        rooms: resp.rooms,
        canLoadMore: resp.hasNext,
        page: resp.page,
      );
    } catch (e) {
      loadingBloc.add(FinishLoading());
      yield ErrorLoadRoomState(
        ErrorUtils.parseError(e),
        rooms: state.rooms,
        page: state.page,
        canLoadMore: state.canLoadMore,
      );
    }
  }
}
