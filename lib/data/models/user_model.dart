import 'package:chat_app/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    int id,
    String code,
    String nickname,
    String fullname,
    String phoneNumber,
    String email,
    String avatar,
  }) : super(
          id: id,
          code: code,
          nickname: nickname,
          fullname: fullname,
          phoneNumber: phoneNumber,
          email: email,
          avatar: avatar,
        );

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    nickname = json['nickname'];
    fullname = json['fullname'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    avatar = json['avatar'];
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
    return data;
  }
}
