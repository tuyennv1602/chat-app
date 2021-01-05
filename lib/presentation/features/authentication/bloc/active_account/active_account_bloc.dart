import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chat_app/common/blocs/loading_bloc/loading_bloc.dart';
import 'package:chat_app/common/blocs/loading_bloc/loading_event.dart';
import 'package:chat_app/common/utils/error_utils.dart';
import 'package:chat_app/domain/usecases/authentication_usecase.dart';
import 'package:meta/meta.dart';
part 'active_account_event.dart';
part 'active_account_state.dart';

class ActiveAccountBloc extends Bloc<ActiveAccountEvent, ActiveAccountState> {
  final LoadingBloc loadingBloc;
  final AuthenticationUseCase authenticationUseCase;

  ActiveAccountBloc({
    this.loadingBloc,
    this.authenticationUseCase,
  }) : super(ActiveAccountInitialState());

  @override
  Stream<ActiveAccountState> mapEventToState(
    ActiveAccountEvent event,
  ) async* {
    switch (event.runtimeType) {
      case SubmitActiveAccountEvent:
        yield* _mapSubmitSignIn(event);
        break;
      default:
    }
  }

  Stream<ActiveAccountState> _mapSubmitSignIn(SubmitActiveAccountEvent event) async* {
    try {
      loadingBloc.add(StartLoading());
      final res = await authenticationUseCase.activeAccount(
        event.email,
        event.verifyCode,
      );
      loadingBloc.add(FinishLoading());
      if (res) {
        yield ActiveAccountSuccessState();
      }
    } catch (e) {
      loadingBloc.add(FinishLoading());
      yield ErroredActiveAccountState(ErrorUtils.parseError(e));
    }
  }
}
