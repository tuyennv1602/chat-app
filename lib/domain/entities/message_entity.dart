import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/network/configs.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:flutter_translate/global.dart';
import 'package:intl/intl.dart';

enum MessageType { text, image, audio, video }

class MessageEntity {
  int id;
  UserModel sender;
  String content;
  String createdAt;
  int type;

  MessageEntity({
    this.id,
    this.sender,
    this.content,
    this.createdAt,
    this.type,
  });

  DateTime get getCreatedAt {
    try {
      return DateFormat('yyyy-MM-dd HH:mm:ss').parse(createdAt);
    } catch (e) {
      return DateTime.now();
    }
  }

  String get getCreatedDay => getCreatedAt.difference(DateTime.now()).inDays == 0
      ? translate(StringConst.today)
      : DateFormat('dd/MM/yyyy').format(getCreatedAt);

  String get getCreatedTime => DateFormat('HH:mm').format(getCreatedAt);

  String get getFullCreatedTime => DateFormat('dd/MM/yyyy HH:mm').format(getCreatedAt);

  String get getMediaUrl => '${Configurations.fileUrl}/$content';

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
