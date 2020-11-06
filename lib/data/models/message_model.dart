import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:equatable/equatable.dart';

class MessageModel extends MessageEntity with EquatableMixin {
  String fileExtension;

  MessageModel({
    int id,
    UserModel sender,
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

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['content_type'] = type;
    data['created_at'] = createdAt;
    if (sender != null) {
      data['created_by'] = sender.toJson();
    }
    return data;
  }

  @override
  List<Object> get props => [id, content];
}
