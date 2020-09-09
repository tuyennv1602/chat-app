import 'package:bloc/bloc.dart';
import 'package:chat_app/common/utils/logger_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SupervisorBloc extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    LOG.info('Event ${event.runtimeType} of ${bloc.runtimeType}');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    LOG.verbose('Transition ${bloc.runtimeType}\n'
        'Current state: ${transition.currentState.runtimeType}\n'
        'Event: ${transition.event.runtimeType}\n'
        'Next state: ${transition.nextState.runtimeType}');
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    LOG.warn('${bloc.runtimeType} Errored', error, stacktrace);
  }
}
