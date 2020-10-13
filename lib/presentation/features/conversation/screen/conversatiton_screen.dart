import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/utils/screen_utils.dart';
import 'package:chat_app/common/widgets/app_bar.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:chat_app/common/widgets/circle_avatar.dart';
import 'package:chat_app/common/widgets/group_avatar.dart';
import 'package:chat_app/domain/entities/room_entity.dart';
import 'package:chat_app/presentation/features/conversation/page/chat_page.dart';
import 'package:chat_app/presentation/features/conversation/screen/option_screen.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_translate/global.dart';
import 'package:sprintf/sprintf.dart';

class ConversationScreen extends StatefulWidget {
  static const String route = '/conversation';
  final RoomEntity room;

  ConversationScreen({Key key, this.room}) : super(key: key);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Column(
        children: [
          AppBarWidget(
            onTapLeading: () => Navigator.of(context).pop(),
            center: Row(
              children: [
                GroupAvatartWidget(
                  members: widget.room.members,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.room.name,
                          style: textStyleAppbar,
                        ),
                        Text(
                          sprintf(translate(StringConst.memberCount), [widget.room.totalMember]),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.warmGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            trailing: SvgPicture.asset(IconConst.menu),
            onTapTrailing: () => Routes.instance.navigate(OptionScreen.route),
          ),
          Expanded(
            child: ChatPage(),
          ),
          Container(color: Colors.white, height: ScreenUtil.bottomBarHeight)
        ],
      ),
    );
  }
}
