import 'package:chat_app/domain/entities/member_position_entity.dart';
import 'package:equatable/equatable.dart';

abstract class MemberPositionState extends Equatable {}

class InitialMemberPositionState extends MemberPositionState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class LoadingMemberPositionState extends InitialMemberPositionState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class LoadedMemberPositionState extends InitialMemberPositionState {
  final List<MemberPositionEntity> positions;

  LoadedMemberPositionState(this.positions);

  @override
  List<Object> get props => [positions];
}

class ErroredMemberPositionState extends InitialMemberPositionState {
  final String error;

  ErroredMemberPositionState(this.error);

  @override
  List<Object> get props => [error];
}
