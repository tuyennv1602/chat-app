import 'dart:math';

import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AnimatedButtonWidget extends StatefulWidget {
  final double buttonSize;
  final Function(bool isOpening) onTap;

  AnimatedButtonWidget({
    Key key,
    this.buttonSize = 45,
    this.onTap,
  }) : super(key: key);

  @override
  _AnimatedButtonWidgetState createState() => _AnimatedButtonWidgetState();
}

class _AnimatedButtonWidgetState extends State<AnimatedButtonWidget>
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

  void _handlePressed() {
    if (_isOpening) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    _isOpening = !_isOpening;
    widget.onTap?.call(_isOpening);
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
        ),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (_, __) => Transform.rotate(
            angle: angle.value * (pi / 4),
            child: SvgPicture.asset(
              IconConst.add,
              width: widget.buttonSize / 2,
              height: widget.buttonSize / 2,
            ),
          ),
        ),
      ),
    );
  }
}
