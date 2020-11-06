import 'package:chat_app/common/blocs/auth_bloc/auth_event.dart';
import 'package:chat_app/common/blocs/auth_bloc/auth_state.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/network/app_header.dart';
import 'package:chat_app/common/network/client.dart';
import 'package:chat_app/common/network/socket_client.dart';
import 'package:chat_app/data/datasource/local/local_datasource.dart';
import 'package:chat_app/data/datasource/remote/user_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:chat_app/common/extensions/string_ext.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Client client;
  final SocketClient socketClient;
  final LocalDataSource localDataSource;
  final UserRemoteDataSource userRemoteDataSource;

  AuthBloc({
    this.client,
    this.socketClient,
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
      case SignedOutEvent:
        yield* _mapSignOutToState(event);
        break;
      case UpdatedAvatarEvent:
        yield* _mapUpdateToState(event);
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
        socketClient.setToken = token;
        final user = await userRemoteDataSource.getUser();
        yield AuthenticatedState(user, token);
      } else {
        yield UnAuthenticatedState();
      }
    } catch (e) {
      await localDataSource.clearAll();
      yield ErroredAuthState(translate(StringConst.unknowError));
    }
  }

  Stream<AuthState> _mapAuthenticatedToState(SignedInEvent event) async* {
    try {
      client.setHeader = AppHeader(accessToken: event.token);
      socketClient.setToken = event.token;
      yield AuthenticatedState(event.user, event.token);
    } catch (e) {
      await localDataSource.clearAll();
      yield ErroredAuthState(translate(StringConst.unknowError));
    }
  }

  Stream<AuthState> _mapSignOutToState(SignedOutEvent event) async* {
    try {
      await localDataSource.clearAll();
      yield UnAuthenticatedState(user: state.user);
    } catch (e) {
      await localDataSource.clearAll();
      yield ErroredAuthState(translate(StringConst.unknowError));
    }
  }

  Stream<AuthState> _mapUpdateToState(UpdatedAvatarEvent event) async* {
    try {
      yield AuthenticatedState(state.user..avatar = event.avatar, state.token);
    } catch (e) {
      await localDataSource.clearAll();
      yield ErroredAuthState(translate(StringConst.unknowError));
    }
  }
}
