// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// InjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  void _configureBlocs() {
    final Container container = Container();
    container.registerSingleton((c) =>
        AuthBloc(client: c<Client>(), localDataSource: c<LocalDataSource>()));
    container.registerSingleton((c) => LoadingBloc());
    container.registerFactory((c) => SignInBloc(
        loadingBloc: c<LoadingBloc>(),
        authenticationUseCase: c<AuthenticationUseCase>(),
        authBloc: c<AuthBloc>()));
    container.registerFactory((c) => SignUpBloc(
        loadingBloc: c<LoadingBloc>(),
        authenticationUseCase: c<AuthenticationUseCase>()));
  }

  void _configureUseCases() {
    final Container container = Container();
    container.registerSingleton((c) => AuthenticationUseCase(
        authenticationRepository: c<AuthenticationRepository>()));
  }

  void _configureRepositories() {
    final Container container = Container();
    container.registerSingleton<AuthenticationRepository,
            AuthenticationRepositoryImpl>(
        (c) => AuthenticationRepositoryImpl(
            remoteDataSource: c<AuthenticationRemoteDataSource>(),
            networkInfo: c<NetworkInfoImpl>(),
            localDataSource: c<LocalDataSource>()));
  }

  void _configureRemoteDataSources() {
    final Container container = Container();
    container.registerSingleton(
        (c) => AuthenticationRemoteDataSource(client: c<Client>()));
  }

  void _configureLocalDataSources() {
    final Container container = Container();
    container.registerSingleton((c) => AppSharedPreference());
    container.registerSingleton(
        (c) => LocalDataSource(sharedPreferences: c<AppSharedPreference>()));
  }

  void _configureCommon() {
    final Container container = Container();
    container.registerSingleton((c) => Client());
    container.registerFactory((c) => NetworkInfoImpl());
  }
}
