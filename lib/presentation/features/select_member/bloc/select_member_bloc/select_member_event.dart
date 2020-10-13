import 'package:chat_app/domain/entities/member_entity.dart';

abstract class SelectMemberEvent {}

class AddMemberEvent extends SelectMemberEvent {
  final MemberEntity member;

  AddMemberEvent(this.member);
}

class RemoveMemberEvent extends SelectMemberEvent {
  final int index;

  RemoveMemberEvent(this.index);
}
