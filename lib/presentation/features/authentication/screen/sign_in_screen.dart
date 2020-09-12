import 'package:chat_app/common/constants/images.dart';
import 'package:chat_app/common/utils/alert_utils.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:chat_app/common/widgets/button_widget.dart';
import 'package:chat_app/common/widgets/custom_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignInScreen extends StatelessWidget {
  static const String route = '/sign_in';
  const SignInScreen({Key key}) : super(key: key);

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}
