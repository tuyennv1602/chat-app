import 'dart:typed_data';

import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/presentation/features/conversation/screen/video_player_screen.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoBox extends StatefulWidget {
  final MessageEntity message;
  final bool isMine;
  final bool isNextBySender;

  const VideoBox({
    Key key,
    this.message,
    this.isMine,
    this.isNextBySender,
  }) : super(key: key);

  @override
  _VideoBoxState createState() => _VideoBoxState();
}

class _VideoBoxState extends State<VideoBox> {
  Uint8List videoThumb;
  @override
  void initState() {
    _loadVideoThumbnail(widget.message.videoUrl);
    super.initState();
  }

  BorderRadius _getBorderRadius() {
    if (widget.isMine) {
      return BorderRadius.only(
        topLeft: const Radius.circular(15),
        topRight: const Radius.circular(15),
        bottomLeft: const Radius.circular(15),
        bottomRight: Radius.circular(widget.isNextBySender ? 15 : 6),
      );
    } else {
      return BorderRadius.only(
        topLeft: const Radius.circular(15),
        topRight: const Radius.circular(15),
        bottomRight: const Radius.circular(15),
        bottomLeft: Radius.circular(widget.isNextBySender ? 15 : 6),
      );
    }
  }

  Future<void> _loadVideoThumbnail(String videoUrl) async {
    final bytes = await VideoThumbnail.thumbnailData(
      video: videoUrl,
      imageFormat: ImageFormat.JPEG,
      quality: 25,
    );
    setState(() {
      videoThumb = bytes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: _getBorderRadius(),
      child: Container(
        height: 140.w,
        width: 220.w,
        color: AppColors.messageBox,
        child: Stack(
          children: [
            videoThumb != null
                ? Image.memory(
                    videoThumb,
                    fit: BoxFit.cover,
                    height: 140.w,
                    width: 220.w,
                  )
                : const SizedBox(),
            Positioned.fill(
              child: GestureDetector(
                onTap: () => Routes.instance.navigate(VideoPlayerScreen.route, arguments: {
                  'message': widget.message,
                }),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: SvgPicture.asset(
                      IconConst.play,
                      color: Colors.white,
                      width: 40.w,
                      height: 40.w,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
