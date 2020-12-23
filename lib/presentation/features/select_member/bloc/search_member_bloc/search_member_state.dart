import 'package:chat_app/domain/entities/member_entity.dart';

abstract class SearchMemberState {}

class InitialSearchMemberState extends SearchMemberState {}

class SearchingMemberState extends SearchMemberState {}

class SearchMemberSuccessState extends SearchMemberState {
  final List<MemberEntity> members;

  SearchMemberSuccessState(this.members);
}

class ErroredSearchMemberState extends SearchMemberState {
  final String error;

  ErroredSearchMemberState(this.error);
}
