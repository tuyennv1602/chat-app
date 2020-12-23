import 'package:chat_app/domain/entities/member_entity.dart';

class CreateRoomEvent {
  final String roomName;
  final List<MemberEntity> members;

  CreateRoomEvent({
    this.roomName,
    this.members,
  });
}
