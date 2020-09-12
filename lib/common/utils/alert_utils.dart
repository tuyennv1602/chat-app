import 'package:flutter/material.dart';

class AlertUtil {
  static void show(
    BuildContext context, {
    @required Widget child,
    bool dismissAble = false,
  }) =>
      showGeneralDialog(
        context: context,
        barrierDismissible: dismissAble,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (_, anim1, anim2) => Material(
          color: Colors.transparent,
          child: child,
        ),
        transitionBuilder: (context, anim1, anim2, child) => SlideTransition(
          // ignore: lines_longer_than_80_chars
          position: Tween(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(anim1),
          child: child,
        ),
      );
}
