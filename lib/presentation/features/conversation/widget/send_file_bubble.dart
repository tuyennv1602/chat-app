import 'package:chat_app/common/injector/injector.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_app/domain/usecases/message_usecase.dart';
import 'package:chat_app/presentation/features/conversation/bloc/socket_bloc/socket_bloc.dart';
import 'package:chat_app/presentation/features/conversation/bloc/upload_file_bloc/upload_file_bloc.dart';
import 'package:chat_app/presentation/features/conversation/bloc/upload_file_bloc/upload_file_event.dart';
import 'package:chat_app/presentation/features/conversation/widget/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendFileBubble extends StatefulWidget {
  final MessageModel message;
  final MessageModel next;
  final MessageModel previous;
  final SocketBloc socketBloc;

  const SendFileBubble({
    Key key,
    this.message,
    this.socketBloc,
    this.next,
    this.previous,
  }) : super(key: key);

  @override
  _SendFileBubbleState createState() => _SendFileBubbleState();
}

class _SendFileBubbleState extends State<SendFileBubble> {
  UploadFileBloc _uploadFileBloc;

  @override
  void initState() {
    _uploadFileBloc = UploadFileBloc(
      socketBloc: widget.socketBloc,
      messageUseCase: Injector.resolve<MessageUseCase>(),
    )..add(
        UploadFileEvent(
          message: widget.message,
          type: widget.message.fileExtension,
          fileName: '${widget.message.sender.id}_',
        ),
      );
    super.initState();
  }

  @override
  void dispose() {
    _uploadFileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _uploadFileBloc,
      child: MessageBubble(
        message: widget.message,
        nextMessage: widget.next,
        previousMessage: widget.previous,
      ),
    );
  }
}
