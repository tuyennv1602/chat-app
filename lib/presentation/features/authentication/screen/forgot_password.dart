import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/images.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/utils/validator.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:chat_app/common/widgets/circle_button.dart';
import 'package:chat_app/common/widgets/input_widget.dart';
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
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
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Form(
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
                  Padding(
                    padding: EdgeInsets.only(
                      top: 80.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          translate(StringConst.forgotPass),
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
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
