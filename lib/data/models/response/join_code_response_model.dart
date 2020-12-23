class JoinCodeResponseModel {
  String roomCode;

  JoinCodeResponseModel.fromJson(Map<String, dynamic> json) {
    roomCode = json['room_code'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['room_code'] = roomCode;
    return data;
  }
}
