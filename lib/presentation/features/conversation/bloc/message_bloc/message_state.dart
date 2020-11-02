import 'package:chat_app/domain/entities/message_entity.dart';

abstract class MessageState {
  List<MessageEntity> messages;

  MessageState({this.messages});
}

class InitialMessageState extends MessageState {
  InitialMessageState() : super(messages: []);
}

class LoadingMessagesState extends MessageState {
  LoadingMessagesState() : super(messages: []);
}

class LoadedMessagesState extends MessageState {
  LoadedMessagesState({List<MessageEntity> messages}) : super(messages: messages);
}

class ErroredMessageState extends MessageState {
  final String error;

  ErroredMessageState({
    List<MessageEntity> messages,
    this.error,
  }) : super(messages: messages);
}
