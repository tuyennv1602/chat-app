import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/images.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:chat_app/common/widgets/circle_button.dart';
import 'package:chat_app/common/widgets/input_widget.dart';
import 'package:chat_app/presentation/features/authentication/forgot_password/presentation/screen.dart/forgot_password.dart';

import 'package:chat_app/presentation/features/authentication/sign_up/presentation/screen.dart/sign_up_screen.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

class SignInScreen extends StatefulWidget {
  static const String route = '/sign_in';
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _enableButton = false;

  void _checkEnableButton() {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      _enableButton = true;
    } else {
      _enableButton = false;
    }
    setState(() {});
  }

  bool get validateAndSave {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

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
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InputWidget(
                            placeHolder: translate(StringConst.email),
                            onChanged: (text) {
                              _checkEnableButton();
                            },
                            controller: email,
                          ),
                          SizedBox(height: 10.h),
                          InputWidget(
                            placeHolder: translate(StringConst.password),
                            onChanged: (text) {
                              _checkEnableButton();
                            },
                            controller: password,
                          ),
                          SizedBox(height: 15.h),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () => Routes.instance
                                  .navigate(ForgotPasswordScreen.route),
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
                                translate(StringConst.signIn),
                                style: textStyleLabel.copyWith(
                                  fontSize: 24.sp,
                                ),
                              ),
                              CircleButtonWidget(
                                isEnable: _enableButton,
                                urlIcon: IconConst.next,
                                onTap: () {},
                              ),
                            ],
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(bottom: 30.h),
                            child: RichText(
                              text: TextSpan(
                                text: translate(StringConst.forgotPass),
                                style: textStyleLabel,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: translate(StringConst.signUp),
                                    style: textStyleLabel.copyWith(
                                      color: AppColors.primaryColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Routes.instance
                                          .navigate(SignUpScreen.route),
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
