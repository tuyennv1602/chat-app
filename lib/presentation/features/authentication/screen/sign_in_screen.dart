import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/images.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:chat_app/common/injector/injector.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/utils/alert_utils.dart';
import 'package:chat_app/common/utils/screen_utils.dart';
import 'package:chat_app/common/utils/validator.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:chat_app/common/widgets/circle_button.dart';
import 'package:chat_app/common/widgets/custom_alert.dart';
import 'package:chat_app/common/widgets/input_widget.dart';
import 'package:chat_app/presentation/features/authentication/bloc/sign_in/sign_in_bloc.dart';
import 'package:chat_app/presentation/features/authentication/bloc/sign_in/sign_in_event.dart';
import 'package:chat_app/presentation/features/authentication/bloc/sign_in/sign_in_state.dart';
import 'package:chat_app/presentation/features/authentication/screen/active_account_screen.dart';
import 'package:chat_app/presentation/features/authentication/screen/forgot_password.dart';
import 'package:chat_app/presentation/features/authentication/screen/sign_up_screen.dart';
import 'package:chat_app/presentation/features/home/screen/home_screen.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

class SignInScreen extends StatefulWidget {
  static const String route = '/sign_in';
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  bool _enableButton = false;
  SignInBloc signInBloc;

  @override
  void initState() {
    signInBloc = Injector.resolve<SignInBloc>();
    super.initState();
  }

  void _checkEnableButton() {
    if (emailCtrl.text.isNotEmpty && passwordCtrl.text.isNotEmpty) {
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
    return BlocProvider.value(
      value: signInBloc,
      child: BlocListener<SignInBloc, SignInState>(
        listener: (_, state) {
          if (state is SignedInState) {
            Routes.instance.navigate(HomeScreen.route);
          }
          if (state is AccountInActiveState) {
            AlertUtil.show(
              context,
              child: CustomAlertWidget(
                title: translate(StringConst.notification),
                message: state.message,
                alertType: AlertType.warning,
                confirmTitle: translate(StringConst.verify),
                cancelTitle: translate(StringConst.cancel),
                onConfirmed: () => Routes.instance.navigate(
                  ActiveAccountScreen.route,
                  arguments: {
                    'email': emailCtrl.text,
                  },
                ),
              ),
            );
          }
          if (state is ErroredSignInState) {
            AlertUtil.show(
              context,
              child: CustomAlertWidget(
                title: translate(StringConst.signInFailed),
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
                  padding: EdgeInsets.symmetric(horizontal: 25.h),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Expanded(
                          flex: 2,
                          child: SizedBox(),
                        ),
                        InputWidget(
                          placeHolder: translate(StringConst.email),
                          validator: Validator.validEmail,
                          onChanged: (text) {
                            _checkEnableButton();
                          },
                          controller: emailCtrl,
                        ),
                        SizedBox(height: 15.h),
                        InputWidget(
                          placeHolder: translate(StringConst.password),
                          validator: Validator.validPassword,
                          onChanged: (text) {
                            _checkEnableButton();
                          },
                          controller: passwordCtrl,
                          obscureText: true,
                        ),
                        SizedBox(height: 15.h),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () => Routes.instance.navigate(
                              ForgotPasswordScreen.route,
                            ),
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
                              onTap: () {
                                if (_validateAndSave) {
                                  signInBloc.add(
                                    SubmitLoginEvent(
                                      email: emailCtrl.text,
                                      password: passwordCtrl.text,
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 30.h + ScreenUtil.bottomBarHeight,
                          ),
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
                                    ..onTap = () => Routes.instance.navigate(
                                          SignUpScreen.route,
                                        ),
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
        ),
      ),
    );
  }
}
