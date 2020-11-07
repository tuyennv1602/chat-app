import 'package:chat_app/common/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/common/blocs/auth_bloc/auth_state.dart';
import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/injector/injector.dart';
import 'package:chat_app/common/utils/alert_utils.dart';
import 'package:chat_app/common/widgets/animated_button.dart';
import 'package:chat_app/common/widgets/app_bar.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:chat_app/common/widgets/circle_avatar.dart';
import 'package:chat_app/common/widgets/custom_alert.dart';
import 'package:chat_app/common/widgets/load_more_loading.dart';
import 'package:chat_app/common/widgets/loading_widget.dart';
import 'package:chat_app/common/widgets/refresh_loading.dart';
import 'package:chat_app/common/widgets/status_widget.dart';
import 'package:chat_app/domain/entities/room_entity.dart';
import 'package:chat_app/presentation/features/conversation/screen/conversatiton_screen.dart';
import 'package:chat_app/presentation/features/home/bloc/room_bloc/room_bloc.dart';
import 'package:chat_app/presentation/features/home/bloc/room_bloc/room_event.dart';
import 'package:chat_app/presentation/features/home/bloc/room_bloc/room_state.dart';
import 'package:chat_app/presentation/features/home/screen/create_room_screen.dart';
import 'package:chat_app/presentation/features/home/widget/fab_menu/fab_menu_overlay.dart';
import 'package:chat_app/presentation/features/home/widget/item_conversation.dart';
import 'package:chat_app/presentation/features/home/widget/join_room_dialog.dart';
import 'package:chat_app/presentation/features/home/widget/notification_badge.dart';
import 'package:chat_app/presentation/features/profile/screen/my_profile_screen.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/home';

  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static final GlobalKey<AnimatedButtonWidgetState> _keyFabButton = GlobalKey();
  final RefreshController _refershController = RefreshController(initialRefresh: false);

  FabMenuOverlay _fabMenu;
  RoomBloc _roomBloc;

  @override
  void initState() {
    _roomBloc = Injector.resolve<RoomBloc>()..add(LoadRoomEvent());
    _fabMenu = FabMenuOverlay(
      context,
      keyItem: _keyFabButton,
      onTapCreateConversation: () {
        _hide();
        _createRoom();
      },
      onTapJoinConversation: () {
        _hide();
        _joinRoom();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _fabMenu?.hide();
    super.dispose();
  }

  void _hide() {
    _fabMenu?.hide();
    _keyFabButton?.currentState?.close();
  }

  void _joinRoom() {
    AlertUtil.show(
      context,
      child: JoinRoomDialog(
        onRequest: (joinCode) => _roomBloc.add(RequestJoinRoomEvent(joinCode)),
      ),
    );
  }

  void _createRoom() {
    Navigator.of(context).pushNamed(CreateRoomScreen.route);
  }

  void _refreshRooms() {
    _roomBloc.add(RefreshRoomEvent());
  }

  void _loadMoreRooms() {
    _roomBloc.add(LoadMoreRoomEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: BlocProvider.value(
        value: _roomBloc,
        child: BlocListener<RoomBloc, RoomState>(
          listener: (BuildContext context, state) {
            if (state is LoadedRoomState || state is ErrorLoadRoomState) {
              _refershController?.refreshCompleted();
              _refershController?.loadComplete();
            }
            if (state is ErrorLoadRoomState) {
              AlertUtil.show(
                context,
                child: CustomAlertWidget.error(
                  title: translate(StringConst.notification),
                  message: state.error,
                ),
              );
            }
          },
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
                          child: BlocBuilder<AuthBloc, AuthState>(
                            builder: (_, state) => CircleAvatarWidget(
                              source: state.user.fullAvatar,
                              isActive: true,
                              onTap: () => Navigator.of(context).pushNamed(MyProfileScreen.route),
                            ),
                          ),
                        ),
                        trailing: SvgPicture.asset(IconConst.search),
                        onTapLeading: () {},
                      ),
                      Expanded(
                        child: BlocBuilder<RoomBloc, RoomState>(
                          builder: (context, state) {
                            if (state is LoadingRoomState) {
                              return LoadingWidget();
                            }
                            return SmartRefresher(
                              enablePullDown: true,
                              enablePullUp: state.canLoadMore,
                              controller: _refershController,
                              onRefresh: _refreshRooms,
                              onLoading: _loadMoreRooms,
                              header: const RefreshLoading(),
                              footer: const LoadMoreLoading(),
                              child: state.rooms.isEmpty && state is LoadedRoomState
                                  ? StatusWidget.empty(
                                      message: translate(StringConst.emptyConversation),
                                    )
                                  : ListView.separated(
                                      padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 10.h),
                                      itemCount: state.rooms.length,
                                      separatorBuilder: (_, index) => Container(height: 5.h),
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (_, index) {
                                        return ItemConversationWidget(
                                          room: state.rooms[index],
                                          onTap: (RoomEntity room) => Routes.instance.navigate(
                                            ConversationScreen.route,
                                            arguments: {'room': room},
                                          ),
                                        );
                                      },
                                    ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 15.h,
                right: 15.h,
                child: AnimatedButtonWidget(
                  key: _keyFabButton,
                  buttonSize: 45.w,
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
        ),
      ),
    );
  }
}
