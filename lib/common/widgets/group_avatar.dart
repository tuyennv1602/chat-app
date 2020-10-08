import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_svg/svg.dart';

class GroupAvatartWidget extends StatelessWidget {
  const GroupAvatartWidget({Key key}) : super(key: key);

  Widget _renderImage(String source) => SizedBox.expand(
        child: source != null
            ? Image.network(
                source,
                fit: BoxFit.cover,
              )
            : SvgPicture.asset(
                IconConst.user,
              ),
      );

  @override
  Widget build(BuildContext context) {
    final _ownerSize = 26.w;
    final _memberSize = 20.w;
    return Container(
      height: 40.w,
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            Positioned(
              top: 3.w,
              child: Container(
                width: _ownerSize,
                height: _ownerSize,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(_ownerSize / 2),
                  child: _renderImage(null),
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: Container(
                width: _memberSize,
                height: _memberSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(_memberSize / 2),
                  child: _renderImage(null),
                ),
              ),
            ),
            Positioned(
              right: 3.w,
              bottom: 5.w,
              child: Container(
                width: _memberSize,
                height: _memberSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(_memberSize / 2),
                  child: _renderImage(null),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Text(
                '+50',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: AppColors.greyText,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
