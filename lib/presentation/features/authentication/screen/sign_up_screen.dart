import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/images.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/utils/screen_utils.dart';
import 'package:chat_app/common/utils/validator.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:chat_app/common/widgets/circle_button.dart';
import 'package:chat_app/common/widgets/input_widget.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class SignUpScreen extends StatefulWidget {
  static const String route = '/sign_up';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController code = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController nickName = TextEditingController();
  bool _enableButton = false;

  void _checkEnableButton() {
    if (code.text.isNotEmpty &&
        email.text.isNotEmpty &&
        password.text.isNotEmpty &&
        fullName.text.isNotEmpty &&
        phone.text.isNotEmpty &&
        nickName.text.isNotEmpty) {
      setState(() {
        _enableButton = true;
      });
    } else {
      setState(() {
        _enableButton = false;
      });
    }
  }

  bool get _validateAndSave {
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
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: ScreenUtil.statusBarHeight + 16,
                      ),
                      child: InkWell(
                        onTap: () => Routes.instance.pop(),
                        child: SvgPicture.asset(
                          IconConst.back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 110.h),
                    Expanded(
                      child: KeyboardAvoider(
                        autoScroll: true,
                        child: Column(
                          children: [
                            InputWidget(
                              placeHolder: translate(StringConst.code),
                              validator: Validator.validCode,
                              controller: code,
                              onChanged: (t) {
                                _checkEnableButton();
                              },
                            ),
                            SizedBox(height: 15.h),
                            InputWidget(
                              placeHolder: translate(StringConst.fullName),
                              validator: Validator.validFullName,
                              controller: fullName,
                              onChanged: (t) {
                                _checkEnableButton();
                              },
                            ),
                            SizedBox(height: 15.h),
                            InputWidget(
                              placeHolder: translate(StringConst.nickName),
                              validator: Validator.validNickName,
                              controller: nickName,
                              onChanged: (t) {
                                _checkEnableButton();
                              },
                            ),
                            SizedBox(height: 15.h),
                            InputWidget(
                              placeHolder: translate(StringConst.email),
                              validator: Validator.validEmail,
                              controller: email,
                              onChanged: (t) {
                                _checkEnableButton();
                              },
                            ),
                            SizedBox(height: 15.h),
                            InputWidget(
                              placeHolder: translate(StringConst.phone),
                              validator: Validator.validPhone,
                              controller: phone,
                              onChanged: (t) {
                                _checkEnableButton();
                              },
                            ),
                            SizedBox(height: 15.h),
                            InputWidget(
                              placeHolder: translate(StringConst.password),
                              validator: Validator.validPassword,
                              controller: password,
                              onChanged: (t) {
                                _checkEnableButton();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 40.h, top: 15.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            translate(StringConst.signUp),
                            style: textStyleLabel.copyWith(
                              fontSize: 24.sp,
                            ),
                          ),
                          CircleButtonWidget(
                            isEnable: _enableButton,
                            urlIcon: IconConst.next,
                            onTap: () {
                              if (_validateAndSave) {}
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
