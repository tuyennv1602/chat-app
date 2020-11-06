import 'package:chat_app/common/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/common/blocs/auth_bloc/auth_event.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/exception/network_exception.dart';
import 'package:chat_app/domain/usecases/user_usecase.dart';
import 'package:chat_app/presentation/features/profile/bloc/avatar_bloc/update_avatar_event.dart';
import 'package:chat_app/presentation/features/profile/bloc/avatar_bloc/update_avatar_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/common/extensions/dio_ext.dart';
import 'package:flutter_translate/flutter_translate.dart';

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
    } on DioError catch (e) {
      yield ErrorUpdateAvatarState(e.errorMessage);
    } on NetworkException catch (e) {
      yield ErrorUpdateAvatarState(e.message);
    } catch (e) {
      yield ErrorUpdateAvatarState(translate(StringConst.unknowError));
    }
  }
}
