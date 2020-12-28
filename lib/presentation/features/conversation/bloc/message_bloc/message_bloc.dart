import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/exception/network_exception.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_app/domain/usecases/message_usecase.dart';
import 'package:chat_app/presentation/features/conversation/bloc/message_bloc/message_event.dart';
import 'package:chat_app/presentation/features/conversation/bloc/message_bloc/message_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/common/extensions/dio_ext.dart';
import 'package:flutter_translate/global.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final _pageSize = 30;
  final MessageUseCase messageUseCase;
  MessageBloc({this.messageUseCase}) : super(InitialMessageState());

  @override
  Stream<MessageState> mapEventToState(MessageEvent event) async* {
    switch (event.runtimeType) {
      case NewMessageEvent:
        yield* _mapNewMessageToState(event);
        break;
      case LoadMessagesEvent:
        yield* _mapLoadMessageToState(event);
        break;
      case UpdateMessageEvent:
        yield* _mapUpdateMessageEvent(event);
        break;
      case LoadMoreMessagesEvent:
        yield* _mapLoadMoreMessageToState(event);
        break;
      default:
    }
  }

  Stream<MessageState> _mapNewMessageToState(NewMessageEvent event) async* {
    yield LoadedMessagesState(
        messages: state.messages..insert(0, event.message), canLoadMore: state.canLoadMore);
  }

  Stream<MessageState> _mapUpdateMessageEvent(UpdateMessageEvent event) async* {
    final _index = state.messages.indexOf(event.oldMessage);
    if (_index != -1) {
      yield LoadedMessagesState(
          messages: state.messages..[_index] = event.newMessage, canLoadMore: state.canLoadMore);
    }
  }

  Stream<MessageState> _mapLoadMessageToState(LoadMessagesEvent event) async* {
    try {
      yield LoadingMessagesState();
      final resp = await messageUseCase.getMessages(event.roomId, 1, _pageSize);
      yield LoadedMessagesState(
        messages: resp.items,
        canLoadMore: resp.hasNext,
        page: resp.page,
      );
    } on DioError catch (e) {
      yield* _handleError(e.errorMessage);
    } on NetworkException catch (e) {
      yield* _handleError(e.message);
    } catch (e) {
      yield* _handleError(translate(StringConst.unknowError));
    }
  }

  Stream<MessageState> _mapLoadMoreMessageToState(LoadMoreMessagesEvent event) async* {
    try {
      final _lastestPage = state.messages.length ~/ _pageSize;
      final resp = await messageUseCase.getMessages(event.roomId, _lastestPage + 1, _pageSize);
      final _newMessages =
          resp.items.toSet().difference(<MessageModel>{...state.messages}).toList();
      yield LoadedMessagesState(
        messages: state.messages..addAll(_newMessages),
        canLoadMore: resp.hasNext,
        page: resp.page,
      );
    } on DioError catch (e) {
      yield* _handleError(e.errorMessage);
    } on NetworkException catch (e) {
      yield* _handleError(e.message);
    } catch (e) {
      yield* _handleError(translate(StringConst.unknowError));
    }
  }

  Stream<MessageState> _handleError(String message) async* {
    yield ErroredMessageState(
      error: message,
      messages: state.messages,
      page: state.page,
      canLoadMore: state.canLoadMore,
    );
  }
}