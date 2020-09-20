import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/exception/app_exception.dart';
import 'package:flutter_translate/flutter_translate.dart';

class NetworkException extends AppException {
  NetworkException()
      : super(
          message: translate(StringConst.connectLost),
        );
}
