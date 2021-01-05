import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/domain/entities/user_entity.dart';

class MessageModel extends MessageEntity {
  String fileExtension;

  MessageModel({
    int id,
    UserEntity sender,
    String content,
    String createdAt,
    int type,
    this.fileExtension,
  }) : super(
          id: id,
          sender: sender,
          content: content,
          createdAt: createdAt,
          type: type,
        );

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['created_by'] != null) {
      sender = UserModel.fromJson(json['created_by']);
    }
    type = json['content_type'];
    content = json['content'];
    createdAt = json['created_at'];
  }
}
