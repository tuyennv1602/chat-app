import 'package:chat_app/common/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/common/blocs/loading_bloc/loading_bloc.dart';
import 'package:chat_app/common/network/client.dart';
import 'package:chat_app/common/network/socket_client.dart';
import 'package:chat_app/common/platform/network_info.dart';
import 'package:chat_app/data/datasource/local/local_datasource.dart';
import 'package:chat_app/data/datasource/remote/authentication_remote_datasource.dart';
import 'package:chat_app/data/datasource/remote/message_remote_datasource.dart';
import 'package:chat_app/data/datasource/remote/room_remote_datasource.dart';
import 'package:chat_app/data/datasource/remote/task_remote_datasource.dart';
import 'package:chat_app/data/datasource/remote/user_remote_datasource.dart';
import 'package:chat_app/data/repositories/authentication_repository_impl.dart';
import 'package:chat_app/data/repositories/message_repository_impl.dart';
import 'package:chat_app/data/repositories/room_repository_impl.dart';
import 'package:chat_app/data/repositories/task_repository_impl.dart';
import 'package:chat_app/data/repositories/user_repository_impl.dart';
import 'package:chat_app/domain/entities/task_entity.dart';
import 'package:chat_app/domain/repositories/authentication_repository.dart';
import 'package:chat_app/domain/repositories/message_repository.dart';
import 'package:chat_app/domain/repositories/room_repository.dart';
import 'package:chat_app/domain/repositories/task_repository.dart';
import 'package:chat_app/domain/repositories/user_repository.dart';
import 'package:chat_app/domain/usecases/authentication_usecase.dart';
import 'package:chat_app/domain/usecases/message_usecase.dart';
import 'package:chat_app/domain/usecases/room_usecase.dart';
import 'package:chat_app/domain/usecases/task_usecase.dart';
import 'package:chat_app/domain/usecases/user_usecase.dart';
import 'package:chat_app/presentation/features/authentication/bloc/active_account/active_account_bloc.dart';
import 'package:chat_app/presentation/features/authentication/bloc/sign_in/sign_in_bloc.dart';
import 'package:chat_app/presentation/features/authentication/bloc/sign_up/sign_up_bloc.dart';
import 'package:chat_app/presentation/features/conversation/bloc/message_bloc/message_bloc.dart';
import 'package:chat_app/presentation/features/conversation/bloc/option_bloc/option_bloc.dart';
import 'package:chat_app/presentation/features/home/bloc/create_room_bloc/create_room_bloc.dart';
import 'package:chat_app/presentation/features/home/bloc/room_bloc/room_bloc.dart';
import 'package:chat_app/presentation/features/profile/bloc/avatar_bloc/update_avatar_bloc.dart';
import 'package:chat_app/presentation/features/select_member/bloc/search_member_bloc/search_member_bloc.dart';
import 'package:chat_app/presentation/features/select_member/bloc/select_member_bloc/select_member_bloc.dart';
import 'package:chat_app/presentation/features/task/bloc/task_detail_bloc/task_detail_bloc.dart';
import 'package:chat_app/presentation/features/task/bloc/task_list_bloc/task_list_bloc.dart';
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
  @Register.factory(UpdateAvatarBloc)
  @Register.singleton(AuthBloc)
  @Register.singleton(LoadingBloc)
  @Register.singleton(RoomBloc)
  @Register.singleton(TaskListBloc)
  @Register.factory(TaskDetailBloc)
  @Register.factory(OptionBloc)
  @Register.factory(SignInBloc)
  @Register.factory(SignUpBloc)
  @Register.factory(ActiveAccountBloc)
  @Register.factory(SearchMemberBloc)
  @Register.factory(SelectMemberBloc)
  @Register.factory(CreateRoomBloc)
  @Register.factory(MessageBloc)
  void _configureBlocs();

  // ============USE CASES==============
  @Register.singleton(MessageUseCase)
  @Register.singleton(AuthenticationUseCase)
  @Register.singleton(RoomUseCase)
  @Register.singleton(TaskUseCase)
  @Register.singleton(UserUseCase)
  void _configureUseCases();

  // ============REPOSITORIES==============
  @Register.singleton(
    MessageRepository,
    from: MessageRepositoryImpl,
  )
  @Register.singleton(
    AuthenticationRepository,
    from: AuthenticationRepositoryImpl,
  )
  @Register.singleton(
    RoomRepository,
    from: RoomRepositoryImpl,
  )
  @Register.singleton(
    TaskRepository,
    from: TaskRepositoryImpl,
  )
  @Register.singleton(
    UserRepository,
    from: UserRepositoryImpl,
  )
  void _configureRepositories();

  // ============REMOTE DATA SOURCE==============
  @Register.singleton(MessageRemoteDataSource)
  @Register.singleton(AuthenticationRemoteDataSource)
  @Register.singleton(RoomRemoteDataSource)
  @Register.singleton(TaskRemoteDataSource)
  @Register.singleton(UserRemoteDataSource)
  void _configureRemoteDataSources();

  // ============LOCAL DATA SOURCE==============
  @Register.singleton(LocalDataSource)
  void _configureLocalDataSources();

  // ============COMMON==============
  @Register.singleton(Client)
  @Register.singleton(SocketClient)
  @Register.factory(NetworkInfoImpl)
  void _configureCommon();
}
