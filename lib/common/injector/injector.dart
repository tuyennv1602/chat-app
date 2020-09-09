import 'package:chat_app/common/blocs/loading_bloc/loading_bloc.dart';
import 'package:chat_app/common/network/client.dart';
import 'package:chat_app/common/platform/network_info.dart';
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
    // _configureUseCases();
    // _configureRepositories();
    // _configureRemoteDataSources();
    // _configureLocalDataSources();
    _configureCommon();
  }

  // ============BLOCS==============
  @Register.singleton(LoadingBloc)
  void _configureBlocs();

  // ============USE CASES==============
  // void _configureUseCases();

  // ============REPOSITORIES==============
  // void _configureRepositories();

  // ============REMOTE DATA SOURCE==============
  // void _configureRemoteDataSources();

  // ============LOCAL DATA SOURCE==============
  // void _configureLocalDataSources();

  // ============COMMON==============
  @Register.singleton(Client)
  @Register.factory(NetworkInfoImpl)
  void _configureCommon();
}
