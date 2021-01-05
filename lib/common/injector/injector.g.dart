// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// InjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  void _configureBlocs() {
    final Container container = Container();
    container.registerFactory((c) => UpdateAvatarBloc(
        userUseCase: c<UserUseCase>(), authBloc: c<AuthBloc>()));
    container.registerSingleton((c) => AuthBloc(
        client: c<Client>(),
        socketClient: c<SocketClient>(),
        localDataSource: c<LocalDataSource>(),
        userRemoteDataSource: c<UserRemoteDataSource>()));
    container.registerSingleton((c) => LoadingBloc());
    container.registerSingleton((c) =>
        RoomBloc(roomUseCase: c<RoomUseCase>(), loadingBloc: c<LoadingBloc>()));
    container.registerFactory((c) => TaskListBloc(
        loadingBloc: c<LoadingBloc>(), taskUseCase: c<TaskUseCase>()));
    container.registerFactory((c) => TaskDetailBloc(
        loadingBloc: c<LoadingBloc>(), taskUseCase: c<TaskUseCase>()));
    container.registerFactory((c) => OptionBloc(
        loadingBloc: c<LoadingBloc>(), roomUseCase: c<RoomUseCase>()));
    container.registerFactory(
        (c) => CreateTaskBloc(c<LoadingBloc>(), c<TaskUseCase>()));
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
    container.registerFactory(
        (c) => MessageBloc(messageUseCase: c<MessageUseCase>()));
    container
        .registerFactory((c) => LocationBloc(roomUseCase: c<RoomUseCase>()));
    container.registerFactory(
        (c) => MemberPositionBloc(roomUseCase: c<RoomUseCase>()));
  }

  void _configureUseCases() {
    final Container container = Container();
    container.registerSingleton(
        (c) => MessageUseCase(messageRepository: c<MessageRepository>()));
    container.registerSingleton((c) => AuthenticationUseCase(
        authenticationRepository: c<AuthenticationRepository>()));
    container.registerSingleton(
        (c) => RoomUseCase(roomRepository: c<RoomRepository>()));
    container.registerSingleton(
        (c) => TaskUseCase(taskRepository: c<TaskRepository>()));
    container.registerSingleton(
        (c) => UserUseCase(userRepository: c<UserRepository>()));
  }

  void _configureRepositories() {
    final Container container = Container();
    container.registerSingleton<MessageRepository, MessageRepositoryImpl>((c) =>
        MessageRepositoryImpl(
            messageRemoteDataSource: c<MessageRemoteDataSource>()));
    container.registerSingleton<AuthenticationRepository,
            AuthenticationRepositoryImpl>(
        (c) => AuthenticationRepositoryImpl(
            remoteDataSource: c<AuthenticationRemoteDataSource>(),
            localDataSource: c<LocalDataSource>()));
    container.registerSingleton<RoomRepository, RoomRepositoryImpl>((c) =>
        RoomRepositoryImpl(roomRemoteDataSource: c<RoomRemoteDataSource>()));
    container.registerSingleton<TaskRepository, TaskRepositoryImpl>(
        (c) => TaskRepositoryImpl(c<TaskRemoteDataSource>()));
    container.registerSingleton<UserRepository, UserRepositoryImpl>((c) =>
        UserRepositoryImpl(userRemoteDataSource: c<UserRemoteDataSource>()));
  }

  void _configureRemoteDataSources() {
    final Container container = Container();
    container
        .registerSingleton((c) => MessageRemoteDataSource(client: c<Client>()));
    container.registerSingleton(
        (c) => AuthenticationRemoteDataSource(client: c<Client>()));
    container
        .registerSingleton((c) => RoomRemoteDataSource(client: c<Client>()));
    container
        .registerSingleton((c) => TaskRemoteDataSource(client: c<Client>()));
    container
        .registerSingleton((c) => UserRemoteDataSource(client: c<Client>()));
  }

  void _configureLocalDataSources() {
    final Container container = Container();
    container.registerSingleton((c) => LocalDataSource());
  }

  void _configureCommon() {
    final Container container = Container();
    container.registerSingleton((c) => Client());
    container.registerSingleton((c) => SocketClient());
    container.registerFactory((c) => NetworkInfoImpl());
  }
}
