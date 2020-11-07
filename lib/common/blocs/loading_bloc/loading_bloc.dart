import 'package:flutter_bloc/flutter_bloc.dart';

import 'loading_event.dart';
import 'loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingBloc() : super(Loaded());

  @override
  Stream<LoadingState> mapEventToState(LoadingEvent event) async* {
    switch (event.runtimeType) {
      case StartLoading:
        yield* _showLoadingState(event);
        break;
      case FinishLoading:
        yield* _finishLoadingState(event);
        break;
    }
  }

  Stream<LoadingState> _showLoadingState(StartLoading event) async* {
    if (state is Loaded) {
      yield Loading();
    }
  }

  Stream<LoadingState> _finishLoadingState(FinishLoading event) async* {
    if (state is Loading) {
      yield Loaded();
    }
  }
}
