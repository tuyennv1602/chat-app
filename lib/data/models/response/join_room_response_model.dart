import 'package:chat_app/data/models/room_model.dart';

class JoinRoomResponseModel {
  RoomModel room;

  JoinRoomResponseModel({this.room});

  JoinRoomResponseModel.fromJson(Map<String, dynamic> json) {
    room = json['room_code'] != null ? RoomModel.fromJson(json['room_code']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (room != null) {
      data['room_code'] = room.toJson();
    }
    return data;
  }
}
