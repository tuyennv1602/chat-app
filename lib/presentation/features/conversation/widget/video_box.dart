import 'dart:typed_data';

import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/presentation/features/conversation/screen/video_player_screen.dart';
import 'package:chat_app/presentation/features/conversation/widget/sending_placehoder.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoBox extends StatefulWidget {
  final MessageEntity message;
  final bool isMine;
  final bool isNextBySender;
  final String token;

  const VideoBox({
    Key key,
    this.message,
    this.isMine,
    this.isNextBySender,
    this.token,
  }) : super(key: key);

  @override
  _VideoBoxState createState() => _VideoBoxState();
}

class _VideoBoxState extends State<VideoBox> {
  Uint8List videoThumb;
  String thumPath;
  String _tempDir;

  @override
  void initState() {
    getTemporaryDirectory().then((d) {
      _tempDir = d.path;
      _loadVideoThumbnail();
    });

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

  Future<void> _loadVideoThumbnail() async {
    if (widget.message.id == null) {
      final path = await VideoThumbnail.thumbnailFile(
        video: widget.message.content,
        thumbnailPath: _tempDir,
        imageFormat: ImageFormat.JPEG,
        quality: 50,
      );
      setState(() {
        thumPath = path;
      });
    } else {
      final bytes = await VideoThumbnail.thumbnailData(
        video: '${widget.message.getMediaUrl}?token=${widget.token}',
        imageFormat: ImageFormat.JPEG,
        quality: 50,
      );
      setState(() {
        videoThumb = bytes;
      });
    }
  }

  Widget _renderThumbImage() {
    if (videoThumb == null && thumPath == null) {
      return const SizedBox();
    }
    if (widget.message.id == null) {
      return SendingPlaceHolder(filePath: thumPath);
    }
    return Image.memory(
      videoThumb,
      fit: BoxFit.cover,
      height: 140.w,
      width: 220.w,
    );
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
            _renderThumbImage(),
            if (widget.message.id != null)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => Routes.instance.navigate(
                    VideoPlayerScreen.route,
                    arguments: {
                      'message': widget.message,
                    },
                  ),
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
          ],
        ),
      ),
    );
  }
}
