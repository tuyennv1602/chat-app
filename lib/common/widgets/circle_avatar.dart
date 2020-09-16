import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';

class CircleAvatarWidget extends StatelessWidget {
  final String source;
  final bool isActive;
  final double size;
  CircleAvatarWidget({
    Key key,
    @required this.source,
    this.size,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = size ?? 40.h;
    return Container(
      width: _size,
      height: _size,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(_size / 2),
            child: source == null
                ? SvgPicture.asset(
                    IconConst.user,
                    width: _size,
                    height: _size,
                  )
                : Image.network(
                    source,
                    width: _size,
                    height: _size,
                    fit: BoxFit.cover,
                  ),
          ),
          if (isActive)
            Positioned(
              right: 1,
              bottom: 0,
              child: Container(
                width: 10.h,
                height: 10.h,
                decoration: BoxDecoration(
                  color: AppColors.lightGreen,
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1.5,
                    color: Colors.white,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
