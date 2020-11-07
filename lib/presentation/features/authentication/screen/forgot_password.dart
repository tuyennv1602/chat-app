import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/images.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/utils/validator.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:chat_app/common/widgets/circle_button.dart';
import 'package:chat_app/common/widgets/input_widget.dart';
import 'package:chat_app/presentation/features/authentication/screen/forgot_password_success_screen.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String route = '/forgot_password';
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  bool _enableButton = false;

  void _checkEnableButton() {
    setState(() {
      _enableButton = email.text.isNotEmpty;
    });
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Routes.instance.pop(),
                  child: Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 10.w),
                    padding: EdgeInsets.all(15.w),
                    child: SvgPicture.asset(
                      IconConst.back,
                      color: Colors.white,
                      width: 22.w,
                      height: 22.w,
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Form(
                    key: _formKey,
                    child: InputWidget(
                      placeHolder: translate(StringConst.email),
                      validator: Validator.validEmail,
                      onChanged: (value) {
                        _checkEnableButton();
                      },
                      controller: email,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 80.h, left: 25.w, right: 25.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        translate(StringConst.forgotPass),
                        style: textStyleBold,
                      ),
                      CircleButtonWidget(
                        isEnable: _enableButton,
                        urlIcon: IconConst.next,
                        onTap: () {
                          if (_validateAndSave) {
                            Routes.instance.navigate(ForgotPasswordSuccessScreen.router);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
