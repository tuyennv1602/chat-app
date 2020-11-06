import 'package:chat_app/data/models/message_model.dart';

class UploadFileEvent {
  final MessageModel message;
  final String fileName;
  final String type;

  UploadFileEvent({
    this.message,
    this.fileName,
    this.type,
  });
}
