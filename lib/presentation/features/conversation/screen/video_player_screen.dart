import 'package:chat_app/common/constants/images.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';

class VideoPlayerScreen extends StatefulWidget {
  static const String route = '/video_player';

  final MessageEntity message;

  VideoPlayerScreen(this.message);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState(message);
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final VideoPlayerController videoPlayerController;
  final MessageEntity message;
  double videoDuration = 0;
  double currentDuration = 0;

  _VideoPlayerScreenState(this.message)
      : videoPlayerController = VideoPlayerController.network(message.videoUrl);

  @override
  void initState() {
    super.initState();
    videoPlayerController.initialize().then((_) {
      setState(() {
        videoDuration = videoPlayerController.value.duration.inMilliseconds.toDouble();
      });
    });

    videoPlayerController.addListener(() {
      setState(() {
        currentDuration = videoPlayerController.value.position.inMilliseconds.toDouble();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Container(
          margin: EdgeInsets.only(top: 20.w),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.w),
              topRight: Radius.circular(20.w),
            ),
            child: Container(
              color: Colors.black,
              child: Column(
                children: <Widget>[
                  Container(
                    color: Colors.black,
                    height: 55.w,
                    child: Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 25.w),
                          iconSize: 25.w,
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.message.sender.nickname,
                                  style: textStyleAppbar.copyWith(color: Colors.white),
                                ),
                                Text(
                                  '${widget.message.getFullCreatedTime}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.white,
                          constraints: const BoxConstraints(maxHeight: 400),
                          child: videoPlayerController.value.initialized
                              ? AspectRatio(
                                  aspectRatio: videoPlayerController.value.aspectRatio,
                                  child: VideoPlayer(videoPlayerController),
                                )
                              : Container(
                                  height: 200,
                                  child: Center(
                                    child: Image.asset(
                                      ImageConst.circleLoading,
                                      width: 30.w,
                                      height: 30.w,
                                    ),
                                  ),
                                ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              iconSize: 28.w,
                              icon: Icon(
                                videoPlayerController.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (videoPlayerController.value.buffered.isNotEmpty &&
                                      videoPlayerController.value.position ==
                                          videoPlayerController.value.buffered[0].end) {
                                    videoPlayerController.seekTo(const Duration(seconds: 0));
                                  }
                                  videoPlayerController.value.isPlaying
                                      ? videoPlayerController.pause()
                                      : videoPlayerController.play();
                                });
                              },
                            ),
                            Expanded(
                              child: Slider(
                                activeColor: Colors.white,
                                inactiveColor: AppColors.warmGrey,
                                value: currentDuration,
                                max: videoDuration,
                                onChanged: (value) => videoPlayerController.seekTo(
                                  Duration(
                                    milliseconds: value.toInt(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }
}
