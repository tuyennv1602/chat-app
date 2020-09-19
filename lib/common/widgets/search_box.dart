import 'package:chat_app/common/constants/images.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';

class SearchBoxWidget extends StatelessWidget {
  final String hintText;
  final bool isLoading;
  final Function(String key) onKeyChanged;

  SearchBoxWidget({
    Key key,
    this.hintText,
    this.isLoading = false,
    @required this.onKeyChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextField(
            cursorColor: AppColors.primaryColor,
            cursorWidth: 1,
            onChanged: onKeyChanged,
            autocorrect: false,
            style: textStyleInput,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
              hintText: hintText,
              hintStyle: textStyleInput.copyWith(color: AppColors.grey),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 0.5,
                  color: AppColors.warmGrey,
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 0.5,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            textInputAction: TextInputAction.search,
          ),
        ),
        isLoading
            ? IconButton(
                icon: Image.asset(
                  ImageConst.circleLoading,
                  width: 25,
                  height: 25,
                  fit: BoxFit.scaleDown,
                ),
                onPressed: () {},
              )
            : IconButton(
                color: Colors.grey,
                icon: const Icon(Icons.close),
                onPressed: () {
                  onKeyChanged('');
                },
              )
      ],
    );
  }
}
