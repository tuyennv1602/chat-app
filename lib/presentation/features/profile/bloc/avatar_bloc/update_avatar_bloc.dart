import 'package:chat_app/common/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/common/blocs/auth_bloc/auth_event.dart';
import 'package:chat_app/common/utils/error_utils.dart';
import 'package:chat_app/domain/usecases/user_usecase.dart';
import 'package:chat_app/presentation/features/profile/bloc/avatar_bloc/update_avatar_event.dart';
import 'package:chat_app/presentation/features/profile/bloc/avatar_bloc/update_avatar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateAvatarBloc extends Bloc<UpdateAvatarEvent, UpdateAvatarState> {
  final UserUseCase userUseCase;
  final AuthBloc authBloc;

  UpdateAvatarBloc({
    this.userUseCase,
    this.authBloc,
  }) : super(InitialUpdateAvatarState());

  @override
  Stream<UpdateAvatarState> mapEventToState(UpdateAvatarEvent event) async* {
    try {
      yield UpdatingAvatarState(event.filePath);
      final resp = await userUseCase.updateAvatar(event.filePath, event.fileName);
      authBloc.add(UpdatedAvatarEvent(resp));
      yield UpdateAvatarSuccessfulState();
    } catch (e) {
      yield ErrorUpdateAvatarState(ErrorUtils.parseError(e));
    }
  }
}
