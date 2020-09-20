import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chat_app/common/blocs/loading_bloc/loading_bloc.dart';
import 'package:chat_app/common/blocs/loading_bloc/loading_event.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/exception/network_exception.dart';
import 'package:chat_app/common/utils/error_utils.dart';
import 'package:chat_app/data/models/register_request_model.dart';
import 'package:chat_app/domain/usecases/authentication_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:meta/meta.dart';
import 'package:chat_app/common/extensions/dio_ext.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final LoadingBloc loadingBloc;
  final AuthenticationUseCase authenticationUseCase;

  SignUpBloc({
    this.loadingBloc,
    this.authenticationUseCase,
  }) : super(SignUpInitial());
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

      final resp =
          await authenticationUseCase.register(event.registerRequestModel);
      loadingBloc.add(FinishLoading());
      yield SignedUpState();
    } on DioError catch (e) {
      if (e.response.data['code'] == ErrorUtils.accountExisted) {
        loadingBloc.add(FinishLoading());
        yield ErroredSignUpState(e.errorMessage);
      } else {
        yield* _handleError(e.errorMessage);
      }
    } on NetworkException catch (e) {
      yield* _handleError(e.message);
    } catch (e) {
      yield* _handleError(translate(StringConst.unknowError));
    }
  }

  Stream<SignUpState> _handleError(String message) async* {
    loadingBloc.add(FinishLoading());
    yield ErroredSignUpState(message);
  }
}
