import 'package:chat_app/common/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Center(
        child: Container(
          width: 50.w,
          height: 50.w,
          child: Center(
            child: Image.asset(ImageConst.loading),
          ),
        ),
      ),
    );
  }
}
