import 'package:chat_app/common/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/injector/injector.dart';
import 'package:chat_app/common/platform/location_check.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/utils/alert_utils.dart';
import 'package:chat_app/common/utils/screen_utils.dart';
import 'package:chat_app/common/widgets/app_bar.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:chat_app/common/widgets/custom_alert.dart';
import 'package:chat_app/common/widgets/toast_widget.dart';
import 'package:chat_app/common/widgets/group_avatar.dart';
import 'package:chat_app/domain/entities/room_entity.dart';
import 'package:chat_app/presentation/features/conversation/bloc/location_bloc/location_bloc.dart';
import 'package:chat_app/presentation/features/conversation/bloc/location_bloc/location_event.dart';
import 'package:chat_app/presentation/features/conversation/bloc/message_bloc/message_bloc.dart';
import 'package:chat_app/presentation/features/conversation/bloc/message_bloc/message_event.dart';
import 'package:chat_app/presentation/features/conversation/bloc/message_bloc/message_state.dart';
import 'package:chat_app/presentation/features/conversation/bloc/socket_bloc/socket_bloc.dart';
import 'package:chat_app/presentation/features/conversation/bloc/socket_bloc/socket_state.dart';
import 'package:chat_app/presentation/features/conversation/page/chat_page.dart';
import 'package:chat_app/presentation/features/conversation/screen/option_screen.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_translate/global.dart';
import 'package:location/location.dart';
import 'package:sprintf/sprintf.dart';

class ConversationScreen extends StatefulWidget {
  static const String route = '/conversation';
  final RoomEntity room;

  ConversationScreen({Key key, this.room}) : super(key: key);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  MessageBloc _messageBloc;
  SocketBloc _socketBloc;
  LocationBloc _locationBloc;
  int _userId;

  @override
  void initState() {
    _userId = Injector.resolve<AuthBloc>().state.user.id;
    _messageBloc = Injector.resolve<MessageBloc>()..add(LoadMessagesEvent(widget.room.id));
    _socketBloc = SocketBloc(
      roomId: widget.room.id,
      messageBloc: _messageBloc,
      userId: _userId,
    );
    _locationBloc = Injector.resolve<LocationBloc>();
    _initLocation();
    super.initState();
  }

  @override
  void dispose() {
    _messageBloc.close();
    _socketBloc.close();
    _locationBloc.close();
    super.dispose();
  }

  Future<void> _initLocation() async {
    final _location = await LocationCheck.initLocation();
    if (_location == null) {
      return;
    }
    final _locationData = await _location.getLocation();
    _locationBloc.add(UpdateLocationEvent(_locationData, widget.room.id, _userId));
    _location.onLocationChanged.listen((LocationData currentLocation) {
      _locationBloc.add(UpdateLocationEvent(currentLocation, widget.room.id, _userId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      dismissKeyboard: false,
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _messageBloc),
          BlocProvider.value(value: _socketBloc)
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<SocketBloc, SocketState>(
              listener: (context, state) {
                if (state is SocketConnectionState) {
                  showToastWidget(ToastWidget.message(message: state.message));
                }
              },
            ),
            BlocListener<MessageBloc, MessageState>(
              listener: (context, state) {
                if (state is ErroredMessageState) {
                  AlertUtil.show(
                    context,
                    child: CustomAlertWidget.error(
                      title: translate(StringConst.notification),
                      message: state.error,
                    ),
                  );
                }
              },
            )
          ],
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
                              sprintf(
                                  translate(StringConst.memberCount), [widget.room.totalMember]),
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
                onTapTrailing: () => Routes.instance.navigate(
                  OptionScreen.route,
                  arguments: {
                    'locationBloc': _locationBloc,
                    'roomId': widget.room.id,
                  },
                ),
              ),
              Expanded(
                child: ChatPage(
                  messageBloc: _messageBloc,
                  socketBloc: _socketBloc,
                  roomId: widget.room.id,
                ),
              ),
              Container(color: Colors.white, height: ScreenUtil.bottomBarHeight)
            ],
          ),
        ),
      ),
    );
  }
}
