import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/images.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/utils/alert_utils.dart';
import 'package:chat_app/common/utils/validator.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:chat_app/common/widgets/circle_button.dart';
import 'package:chat_app/common/widgets/custom_alert.dart';
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
  TextEditingController email = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController nickName = TextEditingController();
  bool _enableButton = false;
  bool autoValidate = false;

  void _checkEnableButton() {
    if (email.text.isNotEmpty &&
        password.text.isNotEmpty &&
        fullName.text.isNotEmpty &&
        phone.text.isNotEmpty &&
        nickName.text.isNotEmpty &&
        confirmPassword.text.isNotEmpty) {
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
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Form(
                key: _formKey,
                autovalidate: autoValidate,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 16,
                      ),
                      child: InkWell(
                        onTap: () => Routes.instance.pop(),
                        child: SvgPicture.asset(
                          IconConst.back,
                        ),
                      ),
                    ),
                    Expanded(
                      child: KeyboardAvoider(
                        autoScroll: true,
                        child: Column(
                          children: [
                            SizedBox(height: 100.h),
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
                            SizedBox(height: 15.h),
                            InputWidget(
                              placeHolder: translate(StringConst.confirmPass),
                              validator: Validator.validPassword,
                              controller: confirmPassword,
                              onChanged: (t) {
                                _checkEnableButton();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.h),
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
                              if (validateAndSave) {
                                if (password.text != confirmPassword.text) {
                                  AlertUtil.show(
                                    context,
                                    child: CustomAlertWidget(
                                      title: 'Thông báo',
                                      message: translate(
                                        StringConst.passwordNotMatch,
                                      ),
                                      alertType: AlertType.error,
                                    ),
                                  );
                                }
                              } else {
                                setState(() {
                                  autoValidate = true;
                                });
                              }
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
