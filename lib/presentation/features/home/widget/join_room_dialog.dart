import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/utils/validator.dart';
import 'package:chat_app/common/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_translate/flutter_translate.dart';

class JoinRoomDialog extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController roomIdCtrl = TextEditingController();
  final Function(String joinCode) onRequest;

  JoinRoomDialog({Key key, this.onRequest}) : super(key: key);

  bool get _validateAndSave {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Wrap(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Text(
                    translate(StringConst.joinConversation),
                    style: textStyleMedium.copyWith(fontSize: 16.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Form(
                    key: _formKey,
                    child: InputWidget(
                      placeHolder: translate(StringConst.joinCodeLabel),
                      validator: Validator.validRoomId,
                      controller: roomIdCtrl,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 32.h,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.greyText,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              translate(StringConst.cancel),
                              style: textStyleRegular.copyWith(
                                color: AppColors.greyText,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (_validateAndSave) {
                              Navigator.of(context).pop();
                              onRequest?.call(roomIdCtrl.text);
                            }
                          },
                          child: Container(
                            height: 32.h,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              translate(StringConst.sendRequest),
                              style: textStyleRegular.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
