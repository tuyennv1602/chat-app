import 'package:chat_app/domain/entities/member_entity.dart';

// ignore: must_be_immutable
class MemberModel extends MemberEntity {
  MemberModel({
    int id,
    String code,
    String nickname,
    String fullname,
    String phoneNumber,
    String email,
    String avatar,
    double lat,
    double lng,
    bool isOnline,
  }) : super(
          id: id,
          code: code,
          nickname: nickname,
          fullname: fullname,
          phoneNumber: phoneNumber,
          email: email,
          avatar: avatar,
          lat: lat,
          lng: lng,
          isOnline: isOnline,
        );

  MemberModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    nickname = json['nickname'];
    fullname = json['fullname'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    avatar = json['avatar'];
    lat = json['lat'];
    lng = json['lng'];
    isOnline = json['online'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['nickname'] = nickname;
    data['fullname'] = fullname;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['avatar'] = avatar;
    data['lat'] = lat;
    data['lng'] = lng;
    data['online'] = isOnline;
    return data;
  }
}
