import 'package:chat_app/domain/entities/user_entity.dart';

class MemberEntity extends UserEntity {
  double lat;
  double lng;
  bool isOnline;

  MemberEntity({
    int id,
    String code,
    String nickname,
    String fullname,
    String phoneNumber,
    String email,
    String avatar,
    this.lat,
    this.lng,
    this.isOnline,
  }) : super(
          id: id,
          code: code,
          nickname: nickname,
          fullname: fullname,
          phoneNumber: phoneNumber,
          email: email,
          avatar: avatar,
        );

  String get getShortName {
    final splits = nickname.split(' ');
    if (splits.length > 1) {
      return '${splits[0]} ${splits[splits.length - 1]}';
    }
    return nickname;
  }
}
