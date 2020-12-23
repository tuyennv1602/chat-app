import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';

class CircleAvatarWidget extends StatelessWidget {
  final String source;
  final bool isActive;
  final double size;
  final Function onTap;
  CircleAvatarWidget({
    Key key,
    @required this.source,
    this.size,
    this.isActive = false,
    this.onTap,
  }) : super(key: key);

  Widget _defaultAvatar() => Container(
        color: AppColors.placeHolder,
      );

  @override
  Widget build(BuildContext context) {
    final _size = (size ?? 45).w;
    return Container(
      width: _size,
      height: _size,
      child: Stack(
        children: [
          GestureDetector(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(_size / 2),
              child: CachedNetworkImage(
                placeholder: (context, url) => _defaultAvatar(),
                errorWidget: (context, url, error) => _defaultAvatar(),
                imageUrl: source,
                fit: BoxFit.cover,
                height: _size,
                width: _size,
                fadeInDuration: Duration.zero,
                fadeOutDuration: Duration.zero,
              ),
            ),
          ),
          if (isActive)
            Positioned(
              right: 1,
              bottom: 0,
              child: Container(
                width: 10.w,
                height: 10.w,
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
