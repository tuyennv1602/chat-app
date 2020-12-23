import 'package:chat_app/common/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LoadMoreLoading extends StatelessWidget {
  final IconPosition iconPosition;

  const LoadMoreLoading({
    Key key,
    this.iconPosition = IconPosition.top,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClassicFooter(
      iconPos: iconPosition,
      failedText: '',
      idleText: '',
      loadingText: '',
      loadingIcon: Image.asset(ImageConst.circleLoading),
      failedIcon: const Icon(Icons.error, color: Colors.red),
      idleIcon: const Icon(
        Icons.arrow_upward,
        color: Colors.grey,
      ),
      outerBuilder: (child) {
        return Container(
          width: 25.w,
          height: 25.w,
          margin: EdgeInsets.symmetric(vertical: 10.w),
          child: Center(
            child: child,
          ),
        );
      },
    );
  }
}
