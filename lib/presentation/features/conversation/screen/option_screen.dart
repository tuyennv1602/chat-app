import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/injector/injector.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/utils/alert_utils.dart';
import 'package:chat_app/common/widgets/app_bar.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:chat_app/common/widgets/custom_alert.dart';
import 'package:chat_app/presentation/features/conversation/bloc/option_bloc/option_bloc.dart';
import 'package:chat_app/presentation/features/conversation/bloc/option_bloc/option_event.dart';
import 'package:chat_app/presentation/features/conversation/bloc/option_bloc/option_state.dart';
import 'package:chat_app/presentation/features/conversation/screen/map_screen.dart';
import 'package:chat_app/presentation/features/conversation/widget/item_conversation_option.dart';
import 'package:chat_app/presentation/features/task/screen/task_list_screen.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/global.dart';
import 'package:share/share.dart';
import 'package:sprintf/sprintf.dart';

class OptionScreen extends StatefulWidget {
  static const String route = '/option';

  @override
  _OptionScreenState createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  OptionBloc _optionBloc;
  @override
  void initState() {
    _optionBloc = Injector.resolve<OptionBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: BlocProvider.value(
        value: _optionBloc,
        child: BlocListener<OptionBloc, OptionState>(
          listener: (context, state) {
            if (state is ErroredOptionState) {
              AlertUtil.show(
                context,
                child: CustomAlertWidget.error(
                  title: translate(StringConst.notification),
                  message: state.error,
                ),
              );
            }
            if (state is LoadedJoinCodeOptionState) {
              AlertUtil.show(
                context,
                child: CustomAlertWidget.success(
                  title: translate(StringConst.notification),
                  message: sprintf(translate(StringConst.getCodeSuccess), [state.joinCode]),
                  confirmTitle: translate(StringConst.share),
                  onConfirmed: () => Share.share(
                    sprintf(translate(StringConst.shareCode), [state.joinCode]),
                  ),
                ),
              );
            }
          },
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
                        title: translate(StringConst.task),
                        onTap: () => Routes.instance.navigate(TaskListScreen.router),
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
                        icon: IconConst.shareCode,
                        title: translate(StringConst.joinCode),
                        onTap: () {
                          _optionBloc.add(GetJoinCodeEvent(5));
                        },
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
        ),
      ),
    );
  }
}
