import 'dart:async';

import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/images.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_svg/svg.dart';

class SearchBoxWidget extends StatefulWidget {
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
  _SearchBoxWidgetState createState() => _SearchBoxWidgetState();
}

class _SearchBoxWidgetState extends State<SearchBoxWidget> {
  Timer _debounce;
  final TextEditingController _keyCtrl = TextEditingController();

  @override
  void dispose() {
    _debounce?.cancel();
    _keyCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextField(
            controller: _keyCtrl,
            cursorColor: AppColors.primaryColor,
            cursorWidth: 1,
            onChanged: (text) {
              if (_debounce?.isActive ?? false) {
                _debounce.cancel();
              }
              _debounce = Timer(
                const Duration(milliseconds: 250),
                () => widget.onKeyChanged(text),
              );
            },
            autocorrect: false,
            style: textStyleInput,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
              hintText: widget.hintText,
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
        widget.isLoading
            ? Container(
                width: 60.w,
                height: 60.w,
                padding: EdgeInsets.all(15.w),
                child: Image.asset(ImageConst.circleLoading),
              )
            : InkWell(
                onTap: () {
                  _keyCtrl.clear();
                  widget.onKeyChanged('');
                },
                child: Container(
                  width: 60.w,
                  height: 60.w,
                  padding: EdgeInsets.all(22.w),
                  child: SvgPicture.asset(IconConst.clear),
                ),
              ),
      ],
    );
  }
}
