import 'package:chat_app/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    int id,
    String code,
    String nickname,
    String fullname,
    String phoneNumber,
    String email,
  }) : super(
          id: id,
          code: code,
          nickname: nickname,
          fullname: fullname,
          phoneNumber: phoneNumber,
          email: email,
        );

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    nickname = json['nickname'];
    fullname = json['fullname'];
    phoneNumber = json['phone_number'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['code'] = code;
    data['nickname'] = nickname;
    data['fullname'] = fullname;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    return data;
  }
}
