import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class InputWidget extends StatelessWidget {
  final String placeHolder;
  final String initValue;
  final bool obscureText;
  final bool editAble;
  final TextInputType inputType;
  final TextInputAction inputAction;
  TextStyle textStyle;
  final TextEditingController controller;
  final TextAlignVertical textAlignVertical;
  final EdgeInsets contentPadding;
  final int maxLines;
  final Widget prefixWidget;
  final Widget suffixWidget;
  final FocusNode focusNode;
  final int maxLength;
  final List<TextInputFormatter> formatters;
  final Function(String) validator;
  final Function(String) onSaved;
  final Function onTap;
  final Function onSubmitted;
  final Function(String) onChanged;

  InputWidget({
    Key key,
    this.placeHolder,
    this.onSaved,
    this.controller,
    this.initValue,
    this.validator,
    this.obscureText = false,
    this.editAble = true,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.done,
    this.textAlignVertical = TextAlignVertical.center,
    this.contentPadding = const EdgeInsets.only(
      top: 0,
      bottom: 10,
      left: 0,
      right: 0,
    ),
    this.maxLines = 1,
    this.prefixWidget,
    this.suffixWidget,
    this.focusNode,
    this.onSubmitted,
    this.maxLength,
    this.onTap,
    this.onChanged,
    this.formatters,
  }) : super(key: key) {
    textStyle = textStyleInput;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      textInputAction: inputAction,
      controller: controller,
      autocorrect: false,
      autofocus: false,
      autovalidate: false,
      enableSuggestions: false,
      maxLines: maxLines,
      maxLength: maxLength,
      obscureText: obscureText,
      cursorColor: AppColors.primaryColor,
      cursorWidth: 1.2,
      style: textStyle,
      textAlignVertical: textAlignVertical,
      onFieldSubmitted: onSubmitted,
      focusNode: focusNode,
      onTap: onTap,
      onSaved: onSaved,
      validator: validator,
      onChanged: onChanged,
      enabled: editAble,
      inputFormatters: formatters,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        suffix: suffixWidget,
        prefix: prefixWidget,
        labelText: placeHolder,
        labelStyle: textStyleInput.copyWith(
          color: AppColors.warmGrey,
        ),
        contentPadding: contentPadding,
        errorStyle: textStyleInputError,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
            color: AppColors.warmGrey,
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
            color: AppColors.red,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
            color: AppColors.primaryColor,
          ),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
            color: AppColors.red,
          ),
        ),
      ),
    );
  }
}
