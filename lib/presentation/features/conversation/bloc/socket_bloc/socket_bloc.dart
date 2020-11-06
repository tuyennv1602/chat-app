import 'package:chat_app/common/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/common/constants/socket_event.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/injector/injector.dart';
import 'package:chat_app/common/network/socket_client.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_app/presentation/features/conversation/bloc/message_bloc/message_bloc.dart';
import 'package:chat_app/presentation/features/conversation/bloc/message_bloc/message_event.dart';
import 'package:chat_app/presentation/features/conversation/bloc/socket_bloc/socket_event.dart';
import 'package:chat_app/presentation/features/conversation/bloc/socket_bloc/socket_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/global.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketBloc extends Bloc<SocketStatusEvent, SocketState> {
  final int roomId;
  SocketClient _socketClient;
  Socket _socket;
  MessageBloc messageBloc;
  AuthBloc authBloc;
  List<MessageModel> sendings = [];
  int userId;

  SocketBloc({
    this.roomId,
    this.messageBloc,
    this.authBloc,
    this.userId,
  }) : super(InitialSocketState()) {
    _initSocket();
  }

  void _initSocket() {
    _socketClient = Injector.resolve<SocketClient>();
    _socket = _socketClient.chat(roomId);
    _socket
      ..on(SocketEvent.connecting, (_) => add(NewStatusEvent(translate(StringConst.connecting))))
      ..on(SocketEvent.reconnecting, (_) => add(NewStatusEvent(translate(StringConst.connecting))))
      ..on(SocketEvent.disconnect, (_) => add(NewStatusEvent(translate(StringConst.disconnect))))
      ..on(SocketEvent.error, (_) => add(ErrorStatusEvent(translate(StringConst.connectError))))
      ..on(SocketEvent.reconnectError,
          (_) => add(ErrorStatusEvent(translate(StringConst.connectError))))
      ..on(SocketEvent.reconnectFailed,
          (_) => add(ErrorStatusEvent(translate(StringConst.connectError))))
      ..on(SocketEvent.connectError,
          (_) => add(ErrorStatusEvent(translate(StringConst.connectError))))
      ..on(SocketEvent.connectTimeout,
          (_) => add(ErrorStatusEvent(translate(StringConst.connectError))))
      ..on(SocketEvent.reconnect, (_) {
        add(NewStatusEvent(translate(StringConst.connected)));
        _socket.emit(SocketTopic.joined, {});
      })
      ..on(SocketEvent.connect, (_) {
        add(NewStatusEvent(translate(StringConst.connected)));
        _socket.emit(SocketTopic.joined, {});
      })
      ..on(SocketTopic.status, (data) {
        debugPrint('>>>>Status: ${data.toString()}');
      })
      ..on(SocketTopic.newMessage, (data) {
        final _message = MessageModel.fromJson(data);
        if (_message.sender.id != userId) {
          messageBloc.add(NewMessageEvent(_message));
        } else {
          _handleSendStatus(_message);
        }
        debugPrint('>>>>>>>${data.toString()}');
      });
  }

  @override
  Future<void> close() {
    _socket
      ..emit(SocketTopic.left, {})
      ..dispose();
    return super.close();
  }

  @override
  Stream<SocketState> mapEventToState(SocketStatusEvent event) async* {
    if (event is NewStatusEvent) {
      yield SocketConnectionState(event.message);
    }
    if (event is ErrorStatusEvent) {
      yield ErroredSocketState(event.message);
    }
    if (event is SendMessageEvent) {
      switch (event.message.type) {
        case 1:
          sendings.add(event.message);
          messageBloc.add(NewMessageEvent(event.message));
          break;
        case 2:
        case 3:
        case 4:
          sendings.add(event.message);
          break;
        default:
      }
      _socket.emit(
        SocketTopic.sendMessage,
        {
          'message_type': event.message.type,
          'content': event.message.content,
        },
      );
    }
  }

  void _handleSendStatus(MessageModel message) {
    for (final item in sendings) {
      if (item.content == message.content) {
        messageBloc.add(UpdateMessageEvent(oldMessage: item, newMessage: message));
        sendings.remove(item);
        break;
      }
    }
  }
}
