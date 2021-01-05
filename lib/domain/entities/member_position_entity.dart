import 'package:chat_app/domain/entities/position_entity.dart';
import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class MemberPositionEntity extends Equatable {
  UserEntity user;
  PositionEntity position;

  MemberPositionEntity({this.position, this.user});

  @override
  List<Object> get props => [user, position];
}
