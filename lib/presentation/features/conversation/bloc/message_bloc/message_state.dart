import 'package:chat_app/domain/entities/message_entity.dart';

abstract class MessageState {
  List<MessageEntity> messages;
  final bool canLoadMore;
  final int page;

  MessageState({
    this.messages,
    this.canLoadMore = false,
    this.page = 1,
  });
}

class InitialMessageState extends MessageState {
  InitialMessageState() : super(messages: [], canLoadMore: false);
}

class LoadingMessagesState extends MessageState {
  LoadingMessagesState() : super(messages: [], canLoadMore: false);
}

class LoadingMoreMessagesState extends MessageState {
  LoadingMoreMessagesState({List<MessageEntity> messages})
      : super(messages: messages, canLoadMore: false);
}

class RefreshingMessagesState extends MessageState {
  RefreshingMessagesState({List<MessageEntity> messages})
      : super(messages: messages, canLoadMore: false);
}

class LoadedMessagesState extends MessageState {
  LoadedMessagesState({
    List<MessageEntity> messages,
    bool canLoadMore,
    int page,
  }) : super(
          messages: messages,
          canLoadMore: canLoadMore,
          page: page,
        );
}

class ErroredMessageState extends MessageState {
  final String error;

  ErroredMessageState({
    List<MessageEntity> messages,
    this.error,
    bool canLoadMore,
    int page,
  }) : super(
          messages: messages,
          canLoadMore: canLoadMore,
          page: page,
        );
}
