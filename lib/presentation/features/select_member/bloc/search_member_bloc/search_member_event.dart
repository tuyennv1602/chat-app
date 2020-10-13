abstract class SearchMemberEvent {}

class RequestSearchMemberEvent extends SearchMemberEvent {
  final String key;

  RequestSearchMemberEvent(this.key);
}

class ClearSearchMemberEvent extends SearchMemberEvent {}
