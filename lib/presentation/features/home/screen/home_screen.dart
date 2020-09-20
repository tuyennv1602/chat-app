import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/widgets/animated_button.dart';
import 'package:chat_app/common/widgets/app_bar.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:chat_app/common/widgets/circle_avatar.dart';
import 'package:chat_app/presentation/features/home/widget/fab_menu/fab_menu_overlay.dart';
import 'package:chat_app/presentation/features/home/widget/item_conversation.dart';
import 'package:chat_app/presentation/features/home/widget/notification_badge.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/home';

  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static final GlobalKey<AnimatedButtonWidgetState> _keyFabButton = GlobalKey();

  FabMenuOverlay _fabMenu;

  @override
  void initState() {
    _fabMenu = FabMenuOverlay(
      context,
      keyItem: _keyFabButton,
      onTapCreateConversation: () {
        _fabMenu?.hide();
        _keyFabButton?.currentState?.close();
      },
      onTapJoinConversation: () {
        _fabMenu?.hide();
        _keyFabButton?.currentState?.close();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _fabMenu?.hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Stack(
        children: [
          Positioned.fill(
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  AppBarWidget(
                    leading: NotificationBadgeWidget(
                      badge: 99,
                      onTap: () {},
                    ),
                    leadingPadding: EdgeInsets.all(12.w),
                    center: Center(
                      child: CircleAvatarWidget(
                        source: null,
                        isActive: true,
                      ),
                    ),
                    trailing: SvgPicture.asset(IconConst.search),
                    onTapLeading: () {},
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.separated(
                        padding: EdgeInsets.fromLTRB(
                          15.w,
                          15.h,
                          15.w,
                          10.h,
                        ),
                        itemCount: 20,
                        separatorBuilder: (_, index) => Container(height: 10.h),
                        itemBuilder: (_, index) {
                          return ItemConversationWidget(
                            conversationId: index,
                            conversationName: 'Group tac chien 1',
                            lastMessage: 'Hey Trung, how are you today?',
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 15.h,
            right: 15.h,
            child: AnimatedButtonWidget(
              key: _keyFabButton,
              buttonSize: 45.h,
              onTap: (isOpening) {
                if (isOpening) {
                  _fabMenu?.hide();
                } else {
                  _fabMenu?.show();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}