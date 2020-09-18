import 'package:chat_app/common/constants/images.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/utils/alert_utils.dart';
import 'package:chat_app/common/utils/screen_utils.dart';
import 'package:chat_app/common/widgets/button_widget.dart';
import 'package:chat_app/common/widgets/custom_alert.dart';
import 'package:chat_app/common/widgets/input_widget.dart';
import 'package:chat_app/presentation/features/authentication/screen/sign_in_screen.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class ActiveAccountScreen extends StatelessWidget {
  static const String router = '/active_account';
  TextEditingController verifyCode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardAvoider(
        autoScroll: true,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          height: ScreenUtil.screenHeightDp,
          child: Column(
            children: [
              SizedBox(height: ScreenUtil.statusBarHeight + 80.h),
              Image.asset(
                ImageConst.clipboard,
                width: 150.w,
                height: 150.w,
              ),
              SizedBox(height: 25.h),
              Text(
                '${translate(StringConst.welcome)}, Hung!',
                style: textStyleLabel.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 24.sp,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                translate(StringConst.registerSuccess),
                style: textStyleLabel.copyWith(
                    fontSize: 18.sp, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25.h),
              InputWidget(
                placeHolder: translate(StringConst.verifyCode),
                controller: verifyCode,
              ),
              const Spacer(),
              ButtonWidget(
                label: translate(StringConst.verify),
                onTap: () {
                  if (verifyCode.text.length == 6) {
                    AlertUtil.show(
                      context,
                      child: CustomAlertWidget(
                        confirmTitle: translate(StringConst.signIn),
                        title: 'Thành công',
                        message:
                            'Tài khoản đã được kích hoạt. Vui lòng đăng nhập lại.',
                        onConfirmed: () {
                          Routes.instance.navigateAndRemove(SignInScreen.route);
                        },
                      ),
                    );
                  } else {
                    AlertUtil.show(
                      context,
                      child: CustomAlertWidget(
                        title: 'Thất bại',
                        message: 'Mã xác thực không hợp lệ!',
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
