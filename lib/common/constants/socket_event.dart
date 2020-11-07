class SocketEvent {
  static const connect = 'connect';
  static const connectError = 'connect_error';
  static const connectTimeout = 'connect_timeout';
  static const connecting = 'connecting';
  static const disconnect = 'disconnect';
  static const error = 'error';
  static const reconnect = 'reconnect';
  static const reconnectAttempt = 'reconnect_attempt';
  static const reconnectFailed = 'reconnect_failed';
  static const reconnectError = 'reconnect_error';
  static const reconnecting = 'reconnecting';
}

class SocketTopic {
  static const status = 'status';
  static const newMessage = 'message_client';
  static const joined = 'joined';
  static const sendMessage = 'message_server';
  static const left = 'left';
}
