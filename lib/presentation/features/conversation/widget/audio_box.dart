import 'package:audioplayers/audioplayers.dart';
import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/images.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/presentation/features/conversation/bloc/upload_file_bloc/upload_file_bloc.dart';
import 'package:chat_app/presentation/features/conversation/bloc/upload_file_bloc/upload_file_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';

class AudioBox extends StatefulWidget {
  final MessageEntity message;
  final bool isMine;
  final bool isNextBySender;
  final String token;

  AudioBox({
    Key key,
    this.message,
    this.isMine,
    this.isNextBySender,
    this.token,
  }) : super(key: key);

  @override
  _AudioBoxState createState() => _AudioBoxState();
}

class _AudioBoxState extends State<AudioBox> {
  final AudioPlayer audioPlayer = AudioPlayer();
  String _url;
  final ValueNotifier<String> _durationNotifier = ValueNotifier('00:00');
  final ValueNotifier<bool> _playNotifier = ValueNotifier(false);
  Duration _duration;

  @override
  void initState() {
    _url = '${widget.message.getMediaUrl}?token=${widget.token}';
    _initDuration();
    _listenAudioPlay();
    super.initState();
  }

  @override
  void dispose() {
    _playNotifier.dispose();
    _durationNotifier.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _initDuration() async {
    await audioPlayer.setUrl(_url);
    await audioPlayer.setReleaseMode(ReleaseMode.STOP);
  }

  void _listenAudioPlay() {
    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState state) {
      _playNotifier.value = state == AudioPlayerState.PLAYING;
      if (state != AudioPlayerState.PLAYING) {
        _durationNotifier.value = durationStr(_duration);
      }
    });
    audioPlayer.onDurationChanged.listen((Duration data) {
      _duration = data;
      _durationNotifier.value = durationStr(data);
    });
    audioPlayer.onAudioPositionChanged.listen((Duration data) {
      _durationNotifier.value =
          durationStr(Duration(microseconds: _duration.inMicroseconds - data.inMicroseconds));
    });
  }

  String durationStr(Duration data) {
    String twoDigits(int n) {
      if (n >= 10) {
        return '$n';
      }
      return '0$n';
    }

    final _hour = data.inHours;
    final twoDigitMinutes = twoDigits(data.inMinutes.remainder(60).toInt());
    final twoDigitSeconds = twoDigits(data.inSeconds.remainder(60).toInt());
    if (_hour > 0) {
      return '$_hour:$twoDigitMinutes:$twoDigitSeconds';
    }
    return '$twoDigitMinutes:$twoDigitSeconds';
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

  Widget _buildPlayButton() => ValueListenableBuilder<bool>(
        valueListenable: _playNotifier,
        builder: (_, isPlaying, __) => GestureDetector(
          onTap: () async {
            if (isPlaying) {
              await audioPlayer.stop();
            } else {
              await audioPlayer.resume();
            }
          },
          child: Container(
            height: 40.w,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Center(
              child: SvgPicture.asset(
                isPlaying ? IconConst.pause : IconConst.play,
                width: 22.w,
                height: 22.w,
                color: isPlaying ? AppColors.primaryColor : AppColors.warmGrey,
              ),
            ),
          ),
        ),
      );

  Widget _buildLoading() => Container(
        height: 40.w,
        width: 45.w,
        child: Center(
          child: BlocBuilder<UploadFileBloc, UploadFileState>(
            builder: (_, state) {
              if (state is ErroredUploadFileState) {
                return Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 25.w,
                );
              }
              return Image.asset(
                ImageConst.circleLoading,
                width: 25.w,
                height: 25.w,
              );
            },
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: _getBorderRadius(),
        border: Border.all(
          color: widget.isMine ? const Color(0xff2E9F60) : AppColors.messageBox,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: !widget.isMine,
            child: widget.message.id == null ? _buildLoading() : _buildPlayButton(),
          ),
          Container(
            padding: EdgeInsets.only(
              left: widget.isMine ? 15.w : 0,
              right: widget.isMine ? 0 : 15.w,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                  child: SvgPicture.asset(
                    IconConst.mp3,
                    width: 30.w,
                    height: 20.w,
                    color: AppColors.warmGrey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w, bottom: 12.w),
                  child: ValueListenableBuilder<String>(
                    valueListenable: _durationNotifier,
                    builder: (_, value, __) => Text(
                      value,
                      style: textStyleRegular.copyWith(fontSize: 12.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: widget.isMine,
            child: widget.message.id == null ? _buildLoading() : _buildPlayButton(),
          ),
        ],
      ),
    );
  }
}
