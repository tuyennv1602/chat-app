import 'package:audioplayers/audioplayers.dart';
import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';

class AudioBox extends StatefulWidget {
  final MessageEntity message;
  final bool isMine;
  final bool isNextBySender;

  AudioBox({
    Key key,
    this.message,
    this.isMine,
    this.isNextBySender,
  }) : super(key: key);

  @override
  _AudioBoxState createState() => _AudioBoxState();
}

class _AudioBoxState extends State<AudioBox> {
  bool isPlaying = false;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    _listenAudioPlay();
    super.initState();
  }

  void _listenAudioPlay() {
    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState state) {
      if (state == AudioPlayerState.PLAYING) {
        setState(() {
          isPlaying = true;
        });
      } else {
        setState(() {
          isPlaying = false;
        });
      }
    });
  }

  Widget _buildPlayButton() => GestureDetector(
        onTap: () async {
          if (isPlaying) {
            await audioPlayer.stop();
          } else {
            await audioPlayer.play(widget.message.audioUrl);
          }
        },
        child: Container(
          height: 40.w,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Center(
            child: SvgPicture.asset(
              IconConst.volume,
              width: 22.w,
              height: 22.w,
              color: isPlaying ? AppColors.primaryColor : AppColors.warmGrey,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: widget.isMine,
            child: _buildPlayButton(),
          ),
          Container(
            width: 100.w,
            child: SvgPicture.asset(
              IconConst.voiceMessage,
              fit: BoxFit.fill,
              color: AppColors.warmGrey,
            ),
          ),
          Visibility(
            visible: !widget.isMine,
            child: _buildPlayButton(),
          ),
        ],
      ),
    );
  }
}
