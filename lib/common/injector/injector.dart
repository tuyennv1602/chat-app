import 'package:chat_app/common/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/common/blocs/loading_bloc/loading_bloc.dart';
import 'package:chat_app/common/network/client.dart';
import 'package:chat_app/common/platform/network_info.dart';
import 'package:chat_app/data/datasource/local/app_shared_preference.dart';
import 'package:chat_app/data/datasource/local/local_datasource.dart';
import 'package:chat_app/data/datasource/remote/authentication_remote_datasource.dart';
import 'package:chat_app/data/repositories/authentication_repository_impl.dart';
import 'package:chat_app/domain/repositories/authentication_repository.dart';
import 'package:chat_app/domain/usecases/authentication_usecase.dart';
import 'package:chat_app/presentation/features/authentication/bloc/sign_in/sign_in_bloc.dart';
import 'package:kiwi/kiwi.dart';

part 'injector.g.dart';

abstract class Injector {
  static Container container;

  static void setup() {
    container = Container();
    _$Injector()._configure();
  }

  // ignore: type_annotate_public_apis
  static final resolve = container.resolve;
  static final clear = container.clear;

  void _configure() {
    _configureBlocs();
    _configureUseCases();
    _configureRepositories();
    _configureRemoteDataSources();
    _configureLocalDataSources();
    _configureCommon();
  }

  // ============BLOCS==============
  @Register.singleton(AuthBloc)
  @Register.singleton(LoadingBloc)
  @Register.factory(SignInBloc)
  void _configureBlocs();

  // ============USE CASES==============
  @Register.singleton(AuthenticationUseCase)
  void _configureUseCases();

  // ============REPOSITORIES==============
  @Register.singleton(
    AuthenticationRepository,
    from: AuthenticationRepositoryImpl,
  )
  void _configureRepositories();

  // ============REMOTE DATA SOURCE==============
  @Register.singleton(AuthenticationRemoteDataSource)
  void _configureRemoteDataSources();

  // ============LOCAL DATA SOURCE==============
  @Register.singleton(AppSharedPreference)
  @Register.singleton(LocalDataSource)
  void _configureLocalDataSources();

  // ============COMMON==============
  @Register.singleton(Client)
  @Register.factory(NetworkInfoImpl)
  void _configureCommon();
}
