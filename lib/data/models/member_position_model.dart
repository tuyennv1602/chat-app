import 'package:chat_app/data/models/position_model.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/domain/entities/member_position_entity.dart';
import 'package:chat_app/domain/entities/position_entity.dart';
import 'package:chat_app/domain/entities/user_entity.dart';

// ignore: must_be_immutable
class MemberPositionModel extends MemberPositionEntity {
  MemberPositionModel({
    UserEntity user,
    PositionEntity position,
  }) : super(user: user, position: position);

  MemberPositionModel.fromJson(Map<String, dynamic> json) {
    if (json['user'] != null) {
      user = UserModel.fromJson(json['user']);
    }
    if (json['position'] != null) {
      position = PositionModel.fromJson(json['position']);
    }
  }
}
