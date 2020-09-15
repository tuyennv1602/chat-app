import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/widgets/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../../../../../common/constants/icons.dart';
import '../../../../../../common/constants/images.dart';
import '../../../../../../common/themes/app_text_theme.dart';
import '../../../../../../common/widgets/base_scaffold.dart';
import '../../../../../../common/widgets/input_widget.dart';
import '../../../../../routes.dart';

class SignUpScreen extends StatefulWidget {
  static const String route = '/sign_up';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                      ),
                    ),
                  ),
                  const Spacer(),
                  InputWidget(
                    placeHolder: translate(StringConst.fullName),
                  ),
                  SizedBox(height: 15.h),
                  InputWidget(
                    placeHolder: translate(StringConst.nickName),
                  ),
                  SizedBox(height: 15.h),
                  InputWidget(
                    placeHolder: translate(StringConst.email),
                  ),
                  SizedBox(height: 15.h),
                  InputWidget(
                    placeHolder: translate(StringConst.phone),
                  ),
                  SizedBox(height: 15.h),
                  InputWidget(
                    placeHolder: translate(StringConst.password),
                  ),
                  SizedBox(height: 15.h),
                  InputWidget(
                    placeHolder: translate(StringConst.confirmPass),
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
                          urlIcon: IconConst.next,
                        ),
                      ],
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
