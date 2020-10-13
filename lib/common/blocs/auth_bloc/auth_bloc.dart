import 'package:chat_app/common/blocs/auth_bloc/auth_event.dart';
import 'package:chat_app/common/blocs/auth_bloc/auth_state.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/network/app_header.dart';
import 'package:chat_app/common/network/client.dart';
import 'package:chat_app/data/datasource/local/local_datasource.dart';
import 'package:chat_app/data/datasource/remote/user_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:chat_app/common/extensions/string_ext.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Client client;
  final LocalDataSource localDataSource;
  final UserRemoteDataSource userRemoteDataSource;

  AuthBloc({
    this.client,
    this.localDataSource,
    this.userRemoteDataSource,
  }) : super(InitialAuthState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    switch (event.runtimeType) {
      case CheckAuthEvent:
        yield* _mapCheckAuthToState(event);
        break;
      case SignedInEvent:
        yield* _mapAuthenticatedToState(event);
        break;
      default:
    }
  }

  Stream<AuthState> _mapCheckAuthToState(CheckAuthEvent event) async* {
    try {
      yield CheckingAuthenticatedState();
      final token = await localDataSource.getToken();
      if (token.isNotEmptyAndNull) {
        client.setHeader = AppHeader(accessToken: token);
        final user = await userRemoteDataSource.getUser();
        yield AuthenticatedState(user);
      } else {
        yield UnAuthenticatedState();
      }
    } catch (e) {
      yield ErroredAuthState(translate(StringConst.unknowError));
      localDataSource.clearAll();
    }
  }

  Stream<AuthState> _mapAuthenticatedToState(SignedInEvent event) async* {
    try {
      client.setHeader = AppHeader(accessToken: event.token);
      yield AuthenticatedState(event.user);
    } catch (e) {
      yield ErroredAuthState(translate(StringConst.unknowError));
      localDataSource.clearAll();
    }
  }
}
