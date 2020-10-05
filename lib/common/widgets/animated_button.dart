import 'dart:math';

import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';

class AnimatedButtonWidget extends StatefulWidget {
  final double buttonSize;
  final Function(bool isOpening) onTap;

  AnimatedButtonWidget({
    Key key,
    this.buttonSize = 45,
    @required this.onTap,
  }) : super(key: key);

  @override
  AnimatedButtonWidgetState createState() => AnimatedButtonWidgetState();
}

class AnimatedButtonWidgetState extends State<AnimatedButtonWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> angle;
  bool _isOpening = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    angle = Tween<double>(begin: 0, end: 1).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void open() {
    _animationController.forward();
    _isOpening = true;
  }

  void close() {
    _animationController.reverse();
    _isOpening = false;
  }

  void _handlePressed() {
    widget.onTap?.call(_isOpening);
    if (_isOpening) {
      close();
    } else {
      open();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _handlePressed,
      borderRadius: BorderRadius.circular(widget.buttonSize / 2),
      child: Container(
        height: widget.buttonSize,
        width: widget.buttonSize,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.gradientButton,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (_, __) => Transform.rotate(
            angle: angle.value * (pi / 4),
            child: SvgPicture.asset(
              IconConst.add,
              width: (widget.buttonSize / 2).w,
              height: (widget.buttonSize / 2).w,
            ),
          ),
        ),
      ),
    );
  }
}
