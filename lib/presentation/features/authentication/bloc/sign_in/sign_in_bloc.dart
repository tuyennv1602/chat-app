import 'package:chat_app/common/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/common/blocs/auth_bloc/auth_event.dart';
import 'package:chat_app/common/blocs/loading_bloc/loading_bloc.dart';
import 'package:chat_app/common/blocs/loading_bloc/loading_event.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/exception/network_exception.dart';
import 'package:chat_app/common/utils/error_utils.dart';
import 'package:chat_app/domain/usecases/authentication_usecase.dart';
import 'package:chat_app/presentation/features/authentication/bloc/sign_in/sign_in_event.dart';
import 'package:chat_app/presentation/features/authentication/bloc/sign_in/sign_in_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:chat_app/common/extensions/dio_ext.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final LoadingBloc loadingBloc;
  final AuthenticationUseCase authenticationUseCase;
  final AuthBloc authBloc;

  SignInBloc({
    this.loadingBloc,
    this.authenticationUseCase,
    this.authBloc,
  }) : super(InitialSignInState());

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    switch (event.runtimeType) {
      case SubmitLoginEvent:
        yield* _mapSubmitSignIn(event);
        break;
      default:
    }
  }

  Stream<SignInState> _mapSubmitSignIn(SubmitLoginEvent event) async* {
    try {
      loadingBloc.add(StartLoading());
      final resp = await authenticationUseCase.login(
        event.email,
        event.password,
      );
      authBloc.add(SignedInEvent(
        token: resp.token,
        user: resp.userModel,
      ));
      loadingBloc.add(FinishLoading());
      yield SignedInState();
    } on DioError catch (e) {
      if (e.response.data['code'] == ErrorUtils.accountInActive) {
        loadingBloc.add(FinishLoading());
        yield AccountInActiveState(e.errorMessage);
      } else {
        yield* _handleError(e.errorMessage);
      }
    } on NetworkException catch (e) {
      yield* _handleError(e.message);
    } catch (e) {
      yield* _handleError(translate(StringConst.unknowError));
    }
  }

  Stream<SignInState> _handleError(String message) async* {
    loadingBloc.add(FinishLoading());
    yield ErroredSignInState(message);
  }
}
