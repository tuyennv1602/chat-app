import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/presentation/features/select_member/bloc/select_member_bloc/select_member_event.dart';
import 'package:chat_app/presentation/features/select_member/bloc/select_member_bloc/select_member_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/global.dart';

class SelectMemberBloc extends Bloc<SelectMemberEvent, SelectMemberState> {
  SelectMemberBloc() : super(InitialSelectMemberState());

  @override
  Stream<SelectMemberState> mapEventToState(SelectMemberEvent event) async* {
    switch (event.runtimeType) {
      case AddMemberEvent:
        yield* _mapAddUserToState(event);
        break;
      case RemoveMemberEvent:
        yield* _mapRemoveUserToState(event);
        break;
      default:
    }
  }

  Stream<SelectMemberState> _mapAddUserToState(AddMemberEvent event) async* {
    try {
      yield SelectedMemberState(users: state.members..add(event.member));
    } catch (e) {
      yield ErroredSelectMemberState(translate(StringConst.unknowError));
    }
  }

  Stream<SelectMemberState> _mapRemoveUserToState(RemoveMemberEvent event) async* {
    try {
      yield SelectedMemberState(users: state.members..removeAt(event.index));
    } catch (e) {
      yield ErroredSelectMemberState(translate(StringConst.unknowError));
    }
  }
}
