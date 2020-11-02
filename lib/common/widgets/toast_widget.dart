import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';

enum ToastType { message, error, success }

// ignore: must_be_immutable
class ToastWidget extends StatelessWidget {
  final String message;
  ToastType type;

  ToastWidget.message({Key key, @required this.message}) : super(key: key) {
    type = ToastType.message;
  }

  ToastWidget.success({Key key, @required this.message}) : super(key: key) {
    type = ToastType.message;
  }

  ToastWidget.error({Key key, @required this.message}) : super(key: key) {
    type = ToastType.message;
  }

  Color get _backgroundColor {
    if (type == ToastType.success) {
      return Colors.green.withOpacity(0.8);
    }
    if (type == ToastType.error) {
      return Colors.red.withOpacity(0.8);
    }
    return Colors.grey.withOpacity(0.8);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 65.w),
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      decoration: BoxDecoration(color: _backgroundColor, borderRadius: BorderRadius.circular(4)),
      child: Text(
        message,
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}
