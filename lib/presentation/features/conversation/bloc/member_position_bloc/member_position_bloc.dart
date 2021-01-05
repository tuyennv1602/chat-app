import 'package:chat_app/common/utils/error_utils.dart';
import 'package:chat_app/domain/usecases/room_usecase.dart';
import 'package:chat_app/presentation/features/conversation/bloc/member_position_bloc/member_position_event.dart';
import 'package:chat_app/presentation/features/conversation/bloc/member_position_bloc/member_position_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberPositionBloc extends Bloc<MemberPositionEvent, MemberPositionState> {
  final RoomUseCase roomUseCase;

  MemberPositionBloc({this.roomUseCase}) : super(InitialMemberPositionState());

  @override
  Stream<MemberPositionState> mapEventToState(MemberPositionEvent event) async* {
    switch (event.runtimeType) {
      case LoadMemberPositionEvent:
        yield* _mapLoadMemberPosition(event);
        break;
      default:
    }
  }

  Stream<MemberPositionState> _mapLoadMemberPosition(LoadMemberPositionEvent event) async* {
    try {
      yield LoadingMemberPositionState();
      final resp = await roomUseCase.getMemberPositions(event.roomId);
      yield LoadedMemberPositionState(resp.data);
    } catch (e) {
      yield ErroredMemberPositionState(ErrorUtils.parseError(e));
    }
  }
}
