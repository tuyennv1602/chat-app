import 'package:chat_app/data/models/message_model.dart';

abstract class SocketState {
  final String message;

  SocketState({this.message});
}

class InitialSocketState extends SocketState {
  InitialSocketState() : super(message: '');
}

class SocketConnectionState extends SocketState {
  SocketConnectionState(String message) : super(message: message);
}

class ErroredSocketState extends SocketState {
  ErroredSocketState(String message) : super(message: message);
}
