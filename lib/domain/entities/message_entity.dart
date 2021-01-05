import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/network/configs.dart';
import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:flutter_translate/global.dart';
import 'package:intl/intl.dart';

class MessageEntity {
  int id;
  UserEntity sender;
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
}
