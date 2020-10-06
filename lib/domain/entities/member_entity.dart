import 'package:chat_app/domain/entities/user_entity.dart';

class MemberEntity extends UserEntity {
  final double lat;
  final double lng;

  MemberEntity({
    int id,
    String code,
    String nickname,
    String fullname,
    String phoneNumber,
    String email,
    this.lat,
    this.lng,
  }) : super(
          id: id,
          code: code,
          nickname: nickname,
          fullname: fullname,
          phoneNumber: phoneNumber,
          email: email,
        );

  String get getShortName {
    final splits = nickname.split(' ');
    if (splits.length > 1) {
      return '${splits[0]} ${splits[splits.length - 1]}';
    }
    return nickname;
  }
}
