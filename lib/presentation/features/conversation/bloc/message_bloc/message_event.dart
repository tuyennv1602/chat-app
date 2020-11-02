import 'package:chat_app/domain/entities/message_entity.dart';

abstract class MessageEvent {}

class NewMessageEvent extends MessageEvent {
  MessageEntity message;
  NewMessageEvent(this.message);
}
