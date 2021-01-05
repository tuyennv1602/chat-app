import 'package:chat_app/common/utils/error_utils.dart';
import 'package:chat_app/domain/usecases/message_usecase.dart';
import 'package:chat_app/presentation/features/conversation/bloc/socket_bloc/socket_bloc.dart';
import 'package:chat_app/presentation/features/conversation/bloc/socket_bloc/socket_event.dart';
import 'package:chat_app/presentation/features/conversation/bloc/upload_file_bloc/upload_file_event.dart';
import 'package:chat_app/presentation/features/conversation/bloc/upload_file_bloc/upload_file_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadFileBloc extends Bloc<UploadFileEvent, UploadFileState> {
  final MessageUseCase messageUseCase;
  final SocketBloc socketBloc;

  UploadFileBloc({
    this.socketBloc,
    this.messageUseCase,
  }) : super(UploadingFileState());

  @override
  Stream<UploadFileState> mapEventToState(UploadFileEvent event) async* {
    try {
      final _message = event.message;
      final resp = await messageUseCase.uploadFile(_message.content, event.fileName, event.type);
      yield UploadedFileState();
      socketBloc.add(SendMessageEvent(message: _message..content = resp));
    } catch (e) {
      yield ErroredUploadFileState(ErrorUtils.parseError(e));
    }
  }
}
