import 'package:equatable/equatable.dart';

abstract class MemberPositionEvent extends Equatable {}

class LoadMemberPositionEvent extends MemberPositionEvent {
  final int roomId;

  LoadMemberPositionEvent(this.roomId);

  @override
  List<Object> get props => [];
}
