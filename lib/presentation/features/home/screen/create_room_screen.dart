import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/injector/injector.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/utils/alert_utils.dart';
import 'package:chat_app/common/utils/validator.dart';
import 'package:chat_app/common/widgets/app_bar.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:chat_app/common/widgets/button_widget.dart';
import 'package:chat_app/common/widgets/circle_button.dart';
import 'package:chat_app/common/widgets/custom_alert.dart';
import 'package:chat_app/common/widgets/input_widget.dart';
import 'package:chat_app/common/widgets/item_member.dart';
import 'package:chat_app/presentation/features/home/bloc/create_room_bloc/create_room_bloc.dart';
import 'package:chat_app/presentation/features/home/bloc/create_room_bloc/create_room_event.dart';
import 'package:chat_app/presentation/features/home/bloc/create_room_bloc/create_room_state.dart';
import 'package:chat_app/presentation/features/select_member/bloc/select_member_bloc/select_member_bloc.dart';
import 'package:chat_app/presentation/features/select_member/bloc/select_member_bloc/select_member_event.dart';
import 'package:chat_app/presentation/features/select_member/bloc/select_member_bloc/select_member_state.dart';
import 'package:chat_app/presentation/features/select_member/screen/select_member_screen.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:chat_app/common/extensions/string_ext.dart';

class CreateRoomScreen extends StatefulWidget {
  static const String route = '/create-room';

  @override
  _CreateRoomScreenState createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _roomNameCtrl = TextEditingController();
  final ValueNotifier<bool> _selectMemberNotifier = ValueNotifier(false);

  SelectMemberBloc _selectMemberBloc;
  CreateRoomBloc _createRoomBloc;

  @override
  void initState() {
    _selectMemberBloc = Injector.resolve<SelectMemberBloc>();
    _createRoomBloc = Injector.resolve<CreateRoomBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _selectMemberNotifier.dispose();
    _createRoomBloc.close();
    super.dispose();
  }

  void _checkEnableButton() {
    if (_roomNameCtrl.text.isEmptyOrNull || _selectMemberBloc.state.members.isEmpty) {
      _selectMemberNotifier.value = false;
    } else {
      _selectMemberNotifier.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: SafeArea(
        top: false,
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: _selectMemberBloc),
            BlocProvider(create: (_) => _createRoomBloc)
          ],
          child: MultiBlocListener(
            listeners: [
              BlocListener<SelectMemberBloc, SelectMemberState>(
                listener: (context, state) {
                  if (state is SelectedMemberState) {
                    _checkEnableButton();
                  }
                },
              ),
              BlocListener<CreateRoomBloc, CreateRoomState>(
                listener: (context, state) {
                  if (state is CreatedRoomSuccessState) {
                    Routes.instance.pop();
                  }
                  if (state is ErroredCreateRoomState) {
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
                  center: Text(
                    translate(StringConst.createConversation),
                    style: textStyleAppbar,
                  ),
                  onTapLeading: () => Navigator.of(context).pop(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  child: Form(
                    key: _formKey,
                    child: InputWidget(
                      placeHolder: translate(StringConst.roomName),
                      validator: Validator.validRoomName,
                      controller: _roomNameCtrl,
                      onChanged: (_) {
                        _checkEnableButton();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                  ),
                  child: Row(
                    children: [
                      Text(
                        translate(StringConst.member),
                        style: textStyleMedium.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context).pushNamed(
                          SelectMemberScreen.route,
                          arguments: {'bloc': _selectMemberBloc},
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 5.h,
                          ),
                          child: CircleButtonWidget(
                            size: 16.h,
                            isEnable: true,
                            padding: EdgeInsets.all(3.w),
                            urlIcon: IconConst.add,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: BlocBuilder<SelectMemberBloc, SelectMemberState>(
                    builder: (context, state) => state is SelectedMemberState
                        ? ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            itemBuilder: (_, index) => ItemMember(
                              member: state.members[index],
                              memberAction: MemberAction.delete,
                              onDelete: () => _selectMemberBloc.add(RemoveMemberEvent(index)),
                            ),
                            separatorBuilder: (_, index) => SizedBox(
                              height: 10.h,
                            ),
                            itemCount: state.members.length,
                          )
                        : const SizedBox(),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: _selectMemberNotifier,
                  builder: (context, isEnable, _) => ButtonWidget(
                    isEnable: isEnable,
                    label: translate(StringConst.createRoom),
                    margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                    onTap: () {
                      _createRoomBloc.add(
                        CreateRoomEvent(
                          roomName: _roomNameCtrl.text,
                          members: _selectMemberBloc.state.members,
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
