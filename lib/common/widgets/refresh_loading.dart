import 'package:chat_app/common/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshLoading extends StatelessWidget {
  final IconPosition iconPosition;

  const RefreshLoading({
    Key key,
    this.iconPosition = IconPosition.top,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClassicHeader(
      iconPos: iconPosition,
      refreshingText: '',
      completeText: '',
      failedText: '',
      releaseText: '',
      canTwoLevelText: '',
      idleText: '',
      failedIcon: const Icon(Icons.error, color: Colors.red),
      completeIcon: const Icon(Icons.done, color: Colors.green),
      idleIcon: const Icon(
        Icons.arrow_downward,
        color: Colors.grey,
      ),
      releaseIcon: const Icon(Icons.refresh, color: Colors.grey),
      refreshingIcon: Image.asset(ImageConst.circleLoading),
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
