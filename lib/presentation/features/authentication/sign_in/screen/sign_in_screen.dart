import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/images.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:chat_app/common/navigation/route_name.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:chat_app/common/widgets/circle_button.dart';
import 'package:chat_app/common/widgets/input_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../../../routes.dart';

class SignInScreen extends StatefulWidget {
  static const String route = '/sign_in';
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: SizedBox.expand(
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                ImageConst.background,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                    flex: 2,
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InputWidget(
                            placeHolder: translate(StringConst.email),
                          ),
                          SizedBox(height: 10.h),
                          InputWidget(
                            placeHolder: translate(StringConst.password),
                          ),
                          SizedBox(height: 15.h),
                          InkWell(
                            onTap: () =>
                                Routes.instance.navigate(RouteName.forgotPass),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                translate(StringConst.forgotPass),
                                style: textStyleInput.copyWith(
                                  color: AppColors.warmGrey,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 45.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Đăng nhập',
                                style: textStyleLabel.copyWith(
                                  fontSize: 24.sp,
                                ),
                              ),
                              CircleButtonWidget(
                                urlIcon: IconConst.next,
                              ),
                            ],
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(bottom: 30.h),
                            child: RichText(
                              text: TextSpan(
                                text: 'Bạn chưa có tài khoản? ',
                                style: textStyleLabel,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Đăng ký',
                                    style: textStyleLabel.copyWith(
                                      color: AppColors.primaryColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Routes.instance
                                          .navigate(RouteName.signUp),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
