import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    String id,
    UserModel sender,
    String content,
    int createdAt,
    int type,
    List<String> images,
    String audioUrl,
    String videoUrl,
    int status,
  }) : super(
          id: id,
          sender: sender,
          content: content,
          createdAt: createdAt,
          type: type,
          images: images,
          audioUrl: audioUrl,
          videoUrl: videoUrl,
          status: status,
        );

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['sender'] != null) {
      sender = UserModel.fromJson(json['sender']);
    }
    type = json['message_type'];
    createdAt = 1603213401;
  }
}
