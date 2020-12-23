import 'package:chat_app/data/models/message_model.dart';

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
  final MessageModel message;

  SendMessageEvent({
    this.message,
  });
}
