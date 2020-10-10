import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/images.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/injector/injector.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/utils/alert_utils.dart';
import 'package:chat_app/common/utils/screen_utils.dart';
import 'package:chat_app/common/utils/validator.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:chat_app/common/widgets/circle_button.dart';
import 'package:chat_app/common/widgets/custom_alert.dart';
import 'package:chat_app/common/widgets/input_widget.dart';
import 'package:chat_app/data/models/register_request_model.dart';
import 'package:chat_app/domain/entities/member_entity.dart';
import 'package:chat_app/presentation/features/authentication/bloc/sign_up/sign_up_bloc.dart';
import 'package:chat_app/presentation/features/authentication/screen/active_account_screen.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  TextEditingController codeCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController fullNameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController nickNameCtrl = TextEditingController();
  bool _enableButton = false;
  SignUpBloc signUpBloc;

  void _checkEnableButton() {
    if (codeCtrl.text.isNotEmpty &&
        emailCtrl.text.isNotEmpty &&
        passwordCtrl.text.isNotEmpty &&
        fullNameCtrl.text.isNotEmpty &&
        phoneCtrl.text.isNotEmpty &&
        nickNameCtrl.text.isNotEmpty) {
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
  void initState() {
    signUpBloc = Injector.resolve<SignUpBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: signUpBloc,
      child: BlocListener<SignUpBloc, SignUpState>(
        listener: (_, state) {
          if (state is SignedUpState) {
            Routes.instance.navigateAndRemove(
              ActiveAccountScreen.route,
              arguments: {
                'email': emailCtrl.text,
                'name': MemberEntity(nickname: fullNameCtrl.text).getShortName,
              },
            );
          }
          if (state is ErroredSignUpState) {
            AlertUtil.show(
              context,
              child: CustomAlertWidget(
                title: translate(StringConst.signUpFailed),
                message: state.error,
              ),
            );
          }
        },
        child: BaseScaffold(
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
                                  controller: codeCtrl,
                                  onChanged: (t) {
                                    _checkEnableButton();
                                  },
                                ),
                                SizedBox(height: 15.h),
                                InputWidget(
                                  placeHolder: translate(StringConst.fullName),
                                  validator: Validator.validFullName,
                                  controller: fullNameCtrl,
                                  onChanged: (t) {
                                    _checkEnableButton();
                                  },
                                ),
                                SizedBox(height: 15.h),
                                InputWidget(
                                  placeHolder: translate(StringConst.nickName),
                                  validator: Validator.validNickName,
                                  controller: nickNameCtrl,
                                  onChanged: (t) {
                                    _checkEnableButton();
                                  },
                                ),
                                SizedBox(height: 15.h),
                                InputWidget(
                                  placeHolder: translate(StringConst.email),
                                  validator: Validator.validEmail,
                                  controller: emailCtrl,
                                  inputType: TextInputType.emailAddress,
                                  onChanged: (t) {
                                    _checkEnableButton();
                                  },
                                ),
                                SizedBox(height: 15.h),
                                InputWidget(
                                  placeHolder: translate(StringConst.phone),
                                  validator: Validator.validPhone,
                                  controller: phoneCtrl,
                                  inputType: TextInputType.phone,
                                  onChanged: (t) {
                                    _checkEnableButton();
                                  },
                                ),
                                SizedBox(height: 15.h),
                                InputWidget(
                                  placeHolder: translate(StringConst.password),
                                  validator: Validator.validPassword,
                                  controller: passwordCtrl,
                                  obscureText: true,
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
                                  if (_validateAndSave) {
                                    signUpBloc.add(
                                      SubmitSignUpEvent(
                                        registerRequestModel:
                                            RegisterRequestModel(
                                          code: codeCtrl.text,
                                          email: emailCtrl.text,
                                          fullname: fullNameCtrl.text,
                                          nickname: nickNameCtrl.text,
                                          password: passwordCtrl.text,
                                          phoneNumber: phoneCtrl.text,
                                        ),
                                      ),
                                    );
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
        ),
      ),
    );
  }
}
