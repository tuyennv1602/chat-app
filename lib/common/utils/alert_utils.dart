import 'package:flutter/material.dart';

class AlertUtil {
  static void show(
    BuildContext context, {
    @required String message,
    String label = 'Thông báo',
    bool showCancel = false,
    String confirmLabel = 'OK',
    Function onConfirmed,
  }) =>
      showGeneralDialog(
        barrierLabel: label,
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: const Duration(milliseconds: 200),
        context: context,
        pageBuilder: (context, anim1, anim2) => Material(
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.center,
            child: Wrap(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          label,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Opensans'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
                        child: Text(
                          message,
                          style: const TextStyle(fontSize: 15, fontFamily: 'Opensans'),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          showCancel
                              ? Expanded(
                                  child: InkWell(
                                    onTap: () => Navigator.of(context).pop(),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 15),
                                      child: Text(
                                        'Cancel',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Opensans'),
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                                if (onConfirmed != null) {
                                  onConfirmed();
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                child: Text(
                                  confirmLabel,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blue,
                                      fontFamily: 'Opensans'),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        transitionBuilder: (context, anim1, anim2, child) => SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(anim1),
          child: child,
        ),
      );

  static void customAlert(BuildContext context, {Widget child}) => showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (_, anim1, anim2) => Material(color: Colors.transparent, child: child),
        transitionBuilder: (context, anim1, anim2, child) => SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(anim1),
          child: child,
        ),
      );
}
