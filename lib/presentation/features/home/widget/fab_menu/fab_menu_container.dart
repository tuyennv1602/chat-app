import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/presentation/features/home/widget/fab_menu/circle_clipper.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

class FabMenuContainer extends StatefulWidget {
  final Offset targetOffset;
  final Size targetSize;
  final Function onTapJoin;
  final Function onTapCreate;

  FabMenuContainer({
    Key key,
    this.targetOffset,
    this.targetSize,
    this.onTapCreate,
    this.onTapJoin,
  }) : super(key: key);

  @override
  _FabMenuContainerState createState() => _FabMenuContainerState();
}

// ignore: lines_longer_than_80_chars
class _FabMenuContainerState extends State<FabMenuContainer> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _positionAnimation;
  Animation<double> _sizeAnimation;

  int currentState = 0;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _positionAnimation = Tween<double>(
      begin: widget.targetSize.height,
      end: 75.h.toDouble(),
    ).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _sizeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    ))
      ..addListener(() {
        setState(() {});
      });
    Future.delayed(const Duration(milliseconds: 50))
        .then((value) => _animationController.forward());
    super.initState();
  }

  Widget _buildItem(String label, String source, Function onTap) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(38.h / 2),
        child: Container(
          height: 38.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(38.h / 2),
          ),
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            children: [
              Text(
                translate(label),
                style: textStyleMedium,
              ),
              SizedBox(width: 10.w),
              SvgPicture.asset(
                source,
                width: 20.w,
                height: 20.w,
                color: AppColors.primaryColor,
              )
            ],
          ),
        ),
      );

  Widget _buildMenuItems() => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildItem(
            StringConst.joinConversation,
            IconConst.group,
            widget.onTapJoin,
          ),
          SizedBox(
            height: 15.h,
          ),
          _buildItem(
            StringConst.createConversation,
            IconConst.createConversation,
            widget.onTapCreate,
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: CircleClipper(
            position: widget.targetOffset,
            icSize: widget.targetSize,
          ),
          child: Container(
            color: AppColors.overlay,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Positioned(
          bottom: _positionAnimation.value,
          right: 15.w,
          child: Transform.scale(
            scale: _sizeAnimation.value,
            child: Material(
              color: Colors.transparent,
              child: _buildMenuItems(),
            ),
          ),
        ),
      ],
    );
  }
}
