abstract class SocketStatusEvent {}

class NewStatusEvent extends SocketStatusEvent {
  final String message;

  NewStatusEvent(this.message);
}

class ErrorStatusEvent extends SocketStatusEvent {
  final String message;

  ErrorStatusEvent(this.message);
}

class SendMessageEvent extends SocketStatusEvent {
  final int type;
  final String content;

  SendMessageEvent({this.type, this.content});
}
