import 'package:chat_app/common/network/configs.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketClient {
  String token;

  set setToken(String token) {
    this.token = token;
  }

  Socket chat(int roomId) {
    return io('${Configurations.socketHost}chat', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'extraHeaders': {
        'token': token,
        'room': roomId,
      }
    });
  }
}
