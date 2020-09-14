import 'package:chat_app/common/utils/alert_utils.dart';
import 'package:chat_app/common/widgets/animated_button.dart';
import 'package:chat_app/common/widgets/app_bar.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:chat_app/common/widgets/button_widget.dart';
import 'package:chat_app/common/widgets/custom_alert.dart';
import 'package:chat_app/presentation/features/authentication/widget/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/home';

  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Column(
        children: [
          AppBarWidget(
            center: Text('data'),
          ),
          ButtonWidget(
              label: 'oke',
              onTap: () => AlertUtil.show(context,
                  child: CustomAlertWidget(
                    title: 'null',
                    message: 'null',
                    confirmTitle: 'đồng ý',
                    cancelTitle: 'cancel',
                  ))),
          AnimatedButtonWidget(
            buttonSize: 45.h,
          ),
          CircleButtonWidget()
        ],
      ),
    );
  }
}
