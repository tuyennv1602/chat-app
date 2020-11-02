import 'package:chat_app/presentation/features/conversation/bloc/message_bloc/message_event.dart';
import 'package:chat_app/presentation/features/conversation/bloc/message_bloc/message_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(InitialMessageState());

  @override
  Stream<MessageState> mapEventToState(MessageEvent event) async* {
    switch (event.runtimeType) {
      case NewMessageEvent:
        yield* _mapNewMessageToState(event);
        break;
      default:
    }
  }

  Stream<MessageState> _mapNewMessageToState(NewMessageEvent event) async* {
    yield LoadedMessagesState(messages: state.messages..insert(0, event.message));
  }
}
