import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/utils/screen_utils.dart';
import 'package:chat_app/common/widgets/button_widget.dart';
import 'package:chat_app/presentation/features/authentication/screen/sign_in_screen.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';

class ForgotPasswordSuccessScreen extends StatelessWidget {
  static const String router = '/forgot_password_done';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(
          children: [
            SizedBox(height: ScreenUtil.statusBarHeight + 80.w),
            SvgPicture.asset(
              IconConst.success,
              width: 150.w,
              height: 150.w,
            ),
            SizedBox(height: 50.h),
            Text(
              translate(StringConst.forgotPasswordDone),
              style: textStyleLabel.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            ButtonWidget(
              label: translate(StringConst.signIn),
              onTap: () {
                Routes.instance.navigateAndRemove(SignInScreen.route);
              },
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
