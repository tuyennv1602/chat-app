import 'package:flutter/material.dart';

class AlertUtil {
  static void show(
    BuildContext context, {
    @required Widget child,
    bool dismissAble = false,
    Offset begin = const Offset(1, 0),
  }) =>
      Future.delayed(const Duration(milliseconds: 5)).then(
        (value) => showGeneralDialog(
          context: context,
          barrierDismissible: dismissAble,
          barrierColor: Colors.black.withOpacity(0.5),
          transitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (_, anim1, anim2) => Material(
            color: Colors.transparent,
            child: child,
          ),
          transitionBuilder: (context, anim1, anim2, child) => SlideTransition(
            position: Tween(begin: begin, end: const Offset(0, 0)).animate(anim1),
            child: child,
          ),
        ),
      );
}
