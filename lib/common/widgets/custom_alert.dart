import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_svg/svg.dart';

enum AlertType { warning, success, error }

// ignore: must_be_immutable
class CustomAlertWidget extends StatelessWidget {
  AlertType alertType;
  final String title;
  final String message;
  final Function onClose;
  final String confirmTitle;
  final String cancelTitle;
  final Function onConfirmed;
  final Function onCancel;

  CustomAlertWidget.error({
    Key key,
    @required this.title,
    @required this.message,
    this.onClose,
    this.confirmTitle,
    this.cancelTitle,
    this.onCancel,
    this.onConfirmed,
  }) : super(key: key) {
    alertType = AlertType.error;
  }

  CustomAlertWidget.success({
    Key key,
    @required this.title,
    @required this.message,
    this.onClose,
    this.confirmTitle,
    this.cancelTitle,
    this.onCancel,
    this.onConfirmed,
  }) : super(key: key) {
    alertType = AlertType.success;
  }

  CustomAlertWidget.warning({
    Key key,
    @required this.title,
    @required this.message,
    this.onClose,
    this.confirmTitle,
    this.cancelTitle,
    this.onCancel,
    this.onConfirmed,
  }) : super(key: key) {
    alertType = AlertType.warning;
  }

  Color _getBackgroundColor() {
    switch (alertType) {
      case AlertType.success:
        return Colors.green.withOpacity(0.2);
      case AlertType.warning:
        return Colors.amber.withOpacity(0.2);
      default:
        return Colors.red.withOpacity(0.2);
    }
  }

  String _getIcon() {
    switch (alertType) {
      case AlertType.success:
        return IconConst.checked;
      case AlertType.warning:
        return IconConst.warning;
      default:
        return IconConst.error;
    }
  }

  Color _getIconColor() {
    switch (alertType) {
      case AlertType.success:
        return Colors.green;
      case AlertType.warning:
        return Colors.amber;
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Wrap(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 25.w,
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 30.w,
                      height: 30.w,
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: _getBackgroundColor(),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          _getIcon(),
                          color: _getIconColor(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.w),
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              message,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.greyText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          onClose?.call();
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.h, right: 25.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (cancelTitle != null)
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            onCancel?.call();
                          },
                          child: Container(
                            height: 32.h,
                            alignment: Alignment.center,
                            // ignore: lines_longer_than_80_chars
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.greyText,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              cancelTitle,
                              style: textStyleMedium.copyWith(
                                color: AppColors.greyText,
                              ),
                            ),
                          ),
                        ),
                      if (confirmTitle != null)
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            onConfirmed?.call();
                          },
                          child: Container(
                            height: 32.h,
                            margin: EdgeInsets.only(left: 10.w),
                            alignment: Alignment.center,
                            // ignore: lines_longer_than_80_chars
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              confirmTitle,
                              style: textStyleMedium.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
