import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/common/constants/images.dart';
import 'package:chat_app/common/themes/app_colors.dart';
// import 'package:chat_app/common/utils/screen_utils.dart';
import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/presentation/features/conversation/screen/gallery_photo_screen.dart';
import 'package:chat_app/presentation/features/conversation/widget/sending_placehoder.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';

class ImageBox extends StatelessWidget {
  final MessageEntity message;
  final bool isMine;
  final bool isNextBySender;
  final String token;

  const ImageBox({
    Key key,
    this.message,
    this.isMine,
    this.isNextBySender,
    this.token,
  }) : super(key: key);

  BorderRadius _getBorderRadius() {
    if (isMine) {
      return BorderRadius.only(
        topLeft: const Radius.circular(15),
        topRight: const Radius.circular(15),
        bottomLeft: const Radius.circular(15),
        bottomRight: Radius.circular(isNextBySender ? 15 : 6),
      );
    } else {
      return BorderRadius.only(
        topLeft: const Radius.circular(15),
        topRight: const Radius.circular(15),
        bottomRight: const Radius.circular(15),
        bottomLeft: Radius.circular(isNextBySender ? 15 : 6),
      );
    }
  }

  Widget _buildLoading() => SizedBox.expand(
        child: Container(
          color: AppColors.messageBox,
          child: Center(
            child: Image.asset(
              ImageConst.circleLoading,
              height: 25,
              width: 25,
            ),
          ),
        ),
      );

  Widget _buildError() => SizedBox.expand(
        child: Container(
          color: AppColors.messageBox,
          child: const Center(
            child: Icon(
              Icons.error,
              color: Colors.red,
            ),
          ),
        ),
      );

  void _viewFullPhoto(int index) => Routes.instance.navigate(
        GalleryPhotoScreen.route,
        arguments: {
          'message': message,
          'index': index,
        },
      );

  Widget _buildImage(double height, int index) => message.id == null
      ? SendingPlaceHolder(filePath: message.content)
      : GestureDetector(
          onTap: () => _viewFullPhoto(index),
          child: CachedNetworkImage(
            placeholder: (context, url) => _buildLoading(),
            errorWidget: (context, url, error) => _buildError(),
            // imageUrl: message.images[index],
            imageUrl: '${message.getMediaUrl}?token=$token',
            fit: BoxFit.cover,
            height: height,
            fadeInDuration: Duration.zero,
            fadeOutDuration: Duration.zero,
          ),
        );

  Widget _renderSingleImage() => SizedBox(
        height: 140.w,
        width: 220.w,
        child: _buildImage(140.w, 0),
      );

  // Widget _renderDoubleImages() => SizedBox(
  //       height: 120.w,
  //       width: ScreenUtil.screenWidthDp * 2 / 3,
  //       child: Row(
  //         children: [
  //           Expanded(
  //             child: _buildImage(120.w, 0),
  //           ),
  //           SizedBox(width: 3.w),
  //           Expanded(
  //             child: _buildImage(120.w, 1),
  //           ),
  //         ],
  //       ),
  //     );

  // Widget _renderMultipleImages() => Container(
  //       height: 90.w,
  //       width: ScreenUtil.screenWidthDp * 2 / 3,
  //       child: Row(
  //         children: [
  //           Expanded(
  //             child: _buildImage(90.w, 0),
  //           ),
  //           SizedBox(width: 3.w),
  //           Expanded(
  //             child: _buildImage(90.w, 1),
  //           ),
  //           SizedBox(width: 3.w),
  //           Expanded(
  //             child: Stack(
  //               children: [
  //                 _buildImage(90.w, 2),
  //                 Visibility(
  //                   visible: message.images.length > 3,
  //                   child: GestureDetector(
  //                     onTap: () => _viewFullPhoto(2),
  //                     child: Container(
  //                       height: 90.w,
  //                       color: Colors.black.withOpacity(0.5),
  //                       child: Center(
  //                         child: Text(
  //                           '+${message.images.length - 3}',
  //                           style: TextStyle(color: Colors.white, fontSize: 18.sp),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     );

  @override
  Widget build(BuildContext context) {
    // Widget _child;
    // final _length = message.images.length;
    // if (_length == 1) {
    //   _child = _renderSingleImage();
    // } else if (_length == 2) {
    //   _child = _renderDoubleImages();
    // } else {
    //   _child = _renderMultipleImages();
    // }
    return ClipRRect(
      borderRadius: _getBorderRadius(),
      child: _renderSingleImage(),
    );
  }
}
