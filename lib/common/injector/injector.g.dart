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
    container.registerSingleton((c) =>
        RoomBloc(roomUseCase: c<RoomUseCase>(), loadingBloc: c<LoadingBloc>()));
    container.registerFactory((c) => OptionBloc(
        loadingBloc: c<LoadingBloc>(), roomUseCase: c<RoomUseCase>()));
    container.registerFactory((c) => SignInBloc(
        loadingBloc: c<LoadingBloc>(),
        authenticationUseCase: c<AuthenticationUseCase>(),
        authBloc: c<AuthBloc>()));
    container.registerFactory((c) => SignUpBloc(
        loadingBloc: c<LoadingBloc>(),
        authenticationUseCase: c<AuthenticationUseCase>()));
    container.registerFactory((c) => ActiveAccountBloc(
        loadingBloc: c<LoadingBloc>(),
        authenticationUseCase: c<AuthenticationUseCase>()));
    container.registerFactory(
        (c) => SearchMemberBloc(userUseCase: c<UserUseCase>()));
    container.registerFactory((c) => SelectMemberBloc());
    container.registerFactory((c) => CreateRoomBloc(
        roomBloc: c<RoomBloc>(),
        loadingBloc: c<LoadingBloc>(),
        roomUseCase: c<RoomUseCase>()));
  }

  void _configureUseCases() {
    final Container container = Container();
    container.registerSingleton((c) => AuthenticationUseCase(
        authenticationRepository: c<AuthenticationRepository>()));
    container.registerSingleton(
        (c) => RoomUseCase(roomRepository: c<RoomRepository>()));
    container.registerSingleton(
        (c) => UserUseCase(userRepository: c<UserRepository>()));
  }

  void _configureRepositories() {
    final Container container = Container();
    container.registerSingleton<AuthenticationRepository,
            AuthenticationRepositoryImpl>(
        (c) => AuthenticationRepositoryImpl(
            remoteDataSource: c<AuthenticationRemoteDataSource>(),
            networkInfo: c<NetworkInfoImpl>(),
            localDataSource: c<LocalDataSource>()));
    container.registerSingleton<RoomRepository, RoomRepositoryImpl>((c) =>
        RoomRepositoryImpl(
            roomRemoteDataSource: c<RoomRemoteDataSource>(),
            networkInfo: c<NetworkInfoImpl>()));
    container.registerSingleton<UserRepository, UserRepositoryImpl>((c) =>
        UserRepositoryImpl(
            userRemoteDataSource: c<UserRemoteDataSource>(),
            networkInfo: c<NetworkInfoImpl>()));
  }

  void _configureRemoteDataSources() {
    final Container container = Container();
    container.registerSingleton(
        (c) => AuthenticationRemoteDataSource(client: c<Client>()));
    container
        .registerSingleton((c) => RoomRemoteDataSource(client: c<Client>()));
    container
        .registerSingleton((c) => UserRemoteDataSource(client: c<Client>()));
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
