enum MessageType { text, image, audio, video }

extension MessageTypeExtension on MessageType {
  int get toValue {
    switch (this) {
      case MessageType.image:
        return 2;
      case MessageType.video:
        return 3;
      case MessageType.audio:
        return 4;
      default:
        return 1;
    }
  }
}

extension MessageTypeValueExtension on num {
  MessageType get toMessageType {
    switch (this) {
      case 2:
        return MessageType.image;
      case 3:
        return MessageType.video;
      case 4:
        return MessageType.audio;
      default:
        return MessageType.text;
    }
  }
}
