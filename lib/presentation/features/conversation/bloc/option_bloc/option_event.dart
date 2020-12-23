abstract class OptionEvent {}

class GetJoinCodeEvent extends OptionEvent {
  final int roomId;

  GetJoinCodeEvent(this.roomId);
}
