import 'package:chat_app/domain/entities/member_entity.dart';
import 'package:chat_app/domain/entities/user_entity.dart';

abstract class SelectMemberState {
  final List<MemberEntity> members;

  SelectMemberState({this.members = const []});
}

class InitialSelectMemberState extends SelectMemberState {
  InitialSelectMemberState() : super(members: []);
}

class SelectedMemberState extends SelectMemberState {
  SelectedMemberState({List<UserEntity> users}) : super(members: users);
}

class ErroredSelectMemberState extends SelectMemberState {
  final String error;

  ErroredSelectMemberState(this.error) : super(members: []);
}
