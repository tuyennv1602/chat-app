import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/widgets/app_bar.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:chat_app/presentation/features/conversation/screen/map_screen.dart';
import 'package:chat_app/presentation/features/conversation/widget/item_conversation_option.dart';
import 'package:chat_app/presentation/features/task/screen/task_list_screen.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';

class OptionScreen extends StatelessWidget {
  static const String route = '/option';

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Column(
        children: [
          AppBarWidget(
            onTapLeading: () => Navigator.of(context).pop(),
            center: Text(
              translate(StringConst.option),
              style: textStyleAppbar,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ItemConversationOption(
                    icon: IconConst.mapPin,
                    title: translate(StringConst.memberLocation),
                    onTap: () => Routes.instance.navigate(MapScreen.route),
                  ),
                  ItemConversationOption(
                    icon: IconConst.task,
                    title: translate(StringConst.taskCombat),
                    onTap: () =>
                        Routes.instance.navigate(TaskListScreen.router),
                  ),
                  ItemConversationOption(
                    icon: IconConst.group,
                    title: translate(StringConst.memberList),
                  ),
                  ItemConversationOption(
                    icon: IconConst.addMember,
                    title: translate(StringConst.addMember),
                  ),
                  ItemConversationOption(
                    icon: IconConst.logout,
                    title: translate(StringConst.leaveRoom),
                  ),
                  ItemConversationOption(
                    icon: IconConst.cancel,
                    title: translate(StringConst.deleteRoom),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
