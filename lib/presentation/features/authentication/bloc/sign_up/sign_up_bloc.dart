import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chat_app/common/blocs/loading_bloc/loading_bloc.dart';
import 'package:chat_app/common/blocs/loading_bloc/loading_event.dart';
import 'package:chat_app/common/utils/error_utils.dart';
import 'package:chat_app/data/models/request/register_request_model.dart';
import 'package:chat_app/domain/usecases/authentication_usecase.dart';
import 'package:meta/meta.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final LoadingBloc loadingBloc;
  final AuthenticationUseCase authenticationUseCase;

  SignUpBloc({
    this.loadingBloc,
    this.authenticationUseCase,
  }) : super(SignUpInitialState());
  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    switch (event.runtimeType) {
      case SubmitSignUpEvent:
        yield* _mapSubmitSignUp(event);
        break;
      default:
    }
  }

  Stream<SignUpState> _mapSubmitSignUp(SubmitSignUpEvent event) async* {
    try {
      loadingBloc.add(StartLoading());
      await authenticationUseCase.register(event.registerRequestModel);
      loadingBloc.add(FinishLoading());
      yield SignedUpState();
    } catch (e) {
      loadingBloc.add(FinishLoading());
      yield ErroredSignUpState(ErrorUtils.parseError(e));
    }
  }
}
