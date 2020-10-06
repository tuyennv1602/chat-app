import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/utils/validator.dart';
import 'package:chat_app/common/widgets/app_bar.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:chat_app/common/widgets/button_widget.dart';
import 'package:chat_app/common/widgets/circle_button.dart';
import 'package:chat_app/common/widgets/input_widget.dart';
import 'package:chat_app/common/widgets/item_member.dart';
import 'package:chat_app/domain/entities/member_entity.dart';
import 'package:chat_app/presentation/features/select_member/screen/select_member_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';

class CreateRoomScreen extends StatelessWidget {
  static const String route = '/create-room';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController roomName = TextEditingController();

  CreateRoomScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: SafeArea(
        top: false,
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
                  controller: roomName,
                  onChanged: (t) {},
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
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                itemBuilder: (_, index) => ItemMember(
                  member: MemberEntity(
                    code: index.toString(),
                    fullname: 'Nguyen Khac Tu',
                    nickname: 'nguyen_tu',
                  ),
                  memberAction: MemberAction.delete,
                ),
                separatorBuilder: (_, index) => SizedBox(
                  height: 10.h,
                ),
                itemCount: 10,
              ),
            ),
            ButtonWidget(
              label: translate(StringConst.createRoom),
              margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
