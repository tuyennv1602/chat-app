import 'package:chat_app/common/utils/error_utils.dart';
import 'package:chat_app/domain/usecases/user_usecase.dart';
import 'package:chat_app/presentation/features/select_member/bloc/search_member_bloc/search_member_event.dart';
import 'package:chat_app/presentation/features/select_member/bloc/search_member_bloc/search_member_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchMemberBloc extends Bloc<SearchMemberEvent, SearchMemberState> {
  final UserUseCase userUseCase;

  SearchMemberBloc({this.userUseCase}) : super(InitialSearchMemberState());

  @override
  Stream<SearchMemberState> mapEventToState(SearchMemberEvent event) async* {
    switch (event.runtimeType) {
      case RequestSearchMemberEvent:
        yield* _mapSearchToState(event);
        break;
      case ClearSearchMemberEvent:
        yield SearchMemberSuccessState([]);
        break;
      default:
    }
  }

  Stream<SearchMemberState> _mapSearchToState(RequestSearchMemberEvent event) async* {
    try {
      yield SearchingMemberState();
      final resp = await userUseCase.searchUser(event.key);
      yield SearchMemberSuccessState(resp.data);
    } catch (e) {
      yield ErroredSearchMemberState(ErrorUtils.parseError(e));
    }
  }
}
