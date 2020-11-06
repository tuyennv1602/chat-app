import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_app/domain/entities/message_entity.dart';

abstract class MessageEvent {}

class LoadMessagesEvent extends MessageEvent {
  final int roomId;

  LoadMessagesEvent(this.roomId);
}

class LoadMoreMessagesEvent extends MessageEvent {
  final int roomId;

  LoadMoreMessagesEvent(this.roomId);
}

class NewMessageEvent extends MessageEvent {
  MessageEntity message;
  NewMessageEvent(this.message);
}

class UpdateMessageEvent extends MessageEvent {
  final MessageModel oldMessage;
  final MessageModel newMessage;

  UpdateMessageEvent({this.oldMessage, this.newMessage});
}
