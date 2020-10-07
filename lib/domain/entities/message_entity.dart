import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:flutter_translate/global.dart';
import 'package:intl/intl.dart';

enum MessageType { text, image, audio, video }

class MessageEntity {
  String id;
  UserEntity sender;
  String content;
  int createdAt;
  int type;
  List<String> images;
  String audioUrl;
  String videoUrl;
  int status;

  MessageEntity({
    this.id,
    this.sender,
    this.content,
    this.createdAt,
    this.type,
    this.images,
    this.audioUrl,
    this.videoUrl,
    this.status,
  });

  DateTime get getCreatedAt => DateTime.fromMillisecondsSinceEpoch(createdAt * 1000);

  String get getCreatedDay => getCreatedAt.difference(DateTime.now()).inDays == 0
      ? translate(StringConst.today)
      : DateFormat('dd/MM/yyyy').format(getCreatedAt);

  String get getCreatedTime => DateFormat('HH:mm').format(getCreatedAt);

  String get getFullCreatedTime => DateFormat('dd/MM/yyyy HH:mm').format(getCreatedAt);

  MessageType get contentType {
    switch (type) {
      case 2:
        return MessageType.image;
        break;
      case 3:
        return MessageType.video;
        break;
      case 4:
        return MessageType.audio;
        break;
      default:
        return MessageType.text;
    }
  }
}
