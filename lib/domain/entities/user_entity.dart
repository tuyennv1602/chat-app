import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UserEntity extends Equatable {
  int id;
  String code;
  String nickname;
  String fullname;
  String phoneNumber;
  String email;
  String avatar;

  UserEntity({
    this.id,
    this.code,
    this.nickname,
    this.fullname,
    this.phoneNumber,
    this.email,
    this.avatar,
  });

  @override
  List<Object> get props => [id, code];
}
