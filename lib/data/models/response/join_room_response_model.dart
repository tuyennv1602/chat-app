import 'package:chat_app/data/models/room_model.dart';

class JoinRoomResponseModel {
  RoomModel room;

  JoinRoomResponseModel({this.room});

  JoinRoomResponseModel.fromJson(Map<String, dynamic> json) {
    room = json['room_code'] != null ? RoomModel.fromJson(json['room_code']) : null;
  }
}
