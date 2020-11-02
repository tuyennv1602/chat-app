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

  SocketBloc({
    this.roomId,
    this.messageBloc,
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
        final message = MessageModel.fromJson(data);
        messageBloc.add(NewMessageEvent(message));
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
      _socket.emit(
        SocketTopic.sendMessage,
        {
          'message_type': event.type,
          'content': event.content,
        },
      );
    }
  }
}
