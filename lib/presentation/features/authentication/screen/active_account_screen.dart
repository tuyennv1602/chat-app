import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/injector/injector.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/utils/alert_utils.dart';
import 'package:chat_app/common/utils/screen_utils.dart';
import 'package:chat_app/common/utils/validator.dart';
import 'package:chat_app/common/widgets/button_widget.dart';
import 'package:chat_app/common/widgets/custom_alert.dart';
import 'package:chat_app/common/widgets/input_widget.dart';
import 'package:chat_app/presentation/features/authentication/bloc/active_account/active_account_bloc.dart';
import 'package:chat_app/presentation/features/authentication/screen/sign_in_screen.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class ActiveAccountScreen extends StatelessWidget {
  static const String route = '/active_account';
  final TextEditingController verifyCodeCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final String email;
  final String name;
  final activeAccountBloc = Injector.resolve<ActiveAccountBloc>();

  ActiveAccountScreen({Key key, this.email, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: activeAccountBloc,
        child: BlocListener<ActiveAccountBloc, ActiveAccountState>(
          listener: (_, state) {
            if (state is ActiveAccountSuccessState) {
              AlertUtil.show(
                context,
                child: CustomAlertWidget.error(
                  confirmTitle: translate(StringConst.signIn),
                  title: 'Thành công',
                  message: 'Tài khoản đã được kích hoạt. Vui lòng đăng nhập lại.',
                  onConfirmed: () {
                    Routes.instance.navigateAndRemove(SignInScreen.route);
                  },
                ),
              );
            }
            if (state is ErroredActiveAccountState) {
              AlertUtil.show(
                context,
                child: CustomAlertWidget.error(
                  title: translate(StringConst.activeAccountFailed),
                  message: state.error,
                ),
              );
            }
          },
          child: KeyboardAvoider(
            autoScroll: true,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              height: ScreenUtil.screenHeightDp,
              child: Column(
                children: [
                  SizedBox(height: ScreenUtil.statusBarHeight + 80.h),
                  SvgPicture.asset(
                    IconConst.registerDone,
                    width: 150.w,
                    height: 150.w,
                  ),
                  SizedBox(height: 25.h),
                  Text(
                    // ignore: lines_longer_than_80_chars
                    '${translate(StringConst.welcome)}${name == null ? '' : ', $name'}!',
                    style: textStyleLabel.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: 24.sp,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    translate(StringConst.registerSuccess),
                    style: textStyleLabel.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 25.h),
                  Form(
                    key: _formKey,
                    child: InputWidget(
                      validator: Validator.validVerifyCode,
                      placeHolder: translate(StringConst.verifyCode),
                      controller: verifyCodeCtrl,
                    ),
                  ),
                  const Spacer(),
                  ButtonWidget(
                    label: translate(StringConst.verify),
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        activeAccountBloc.add(
                          SubmitActiveAccountEvent(
                            email: email,
                            verifyCode: verifyCodeCtrl.text,
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
        ),
      ),
    );
  }
}
