// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// InjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  void _configureBlocs() {
    final Container container = Container();
    container.registerSingleton((c) => LoadingBloc());
  }

  void _configureCommon() {
    final Container container = Container();
    container.registerSingleton((c) => Client());
    container.registerFactory((c) => NetworkInfoImpl());
  }
}
