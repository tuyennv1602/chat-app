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
  final ValueNotifier<Duration> _durationNotifier = ValueNotifier(const Duration());
  final ValueNotifier<bool> _playNotifier = ValueNotifier(false);
  Duration _duration = const Duration(microseconds: 1);

  @override
  void initState() {
    _url = '${widget.message.getMediaUrl}?token=${widget.token}';
    _initDuration();
    _listenAudioPlay();
    super.initState();
  }

  @override
  void dispose() {
    _playNotifier?.dispose();
    _durationNotifier?.dispose();
    audioPlayer?.dispose();
    super.dispose();
  }

  Future<void> _initDuration() async {
    await audioPlayer.setUrl(_url);
    await audioPlayer.setReleaseMode(ReleaseMode.LOOP);
  }

  void _listenAudioPlay() {
    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState state) {
      _playNotifier.value = state == AudioPlayerState.PLAYING;
      if (state != AudioPlayerState.PLAYING) {
        _durationNotifier.value = const Duration();
      }
    });
    audioPlayer.onDurationChanged.listen((Duration data) {
      setState(() {
        _duration = data;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((Duration data) {
      _durationNotifier.value = data;
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
    return BorderRadius.only(
      topLeft: const Radius.circular(15),
      topRight: const Radius.circular(15),
      bottomLeft: widget.isMine
          ? const Radius.circular(15)
          : Radius.circular(widget.isNextBySender ? 15 : 6),
      bottomRight: widget.isMine
          ? Radius.circular(widget.isNextBySender ? 15 : 6)
          : const Radius.circular(15),
    );
  }

  Widget _buildPlayButton() => ValueListenableBuilder<bool>(
        valueListenable: _playNotifier,
        builder: (_, isPlaying, __) => GestureDetector(
          onTap: () async {
            if (isPlaying) {
              await audioPlayer.pause();
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
          Container(
            padding: EdgeInsets.only(left: 15.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                  child: SvgPicture.asset(
                    IconConst.mp3,
                    width: 25.w,
                    height: 18.w,
                    color: AppColors.warmGrey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w, bottom: 15.w),
                  child: ValueListenableBuilder<Duration>(
                    valueListenable: _durationNotifier,
                    builder: (_, value, __) => Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100.w,
                          height: 6.w,
                          margin: EdgeInsets.only(bottom: 3.w),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(3.w),
                            child: LinearProgressIndicator(
                              backgroundColor: AppColors.line,
                              value: value.inMicroseconds / _duration.inMicroseconds,
                            ),
                          ),
                        ),
                        Container(
                          width: 40.w,
                          child: Text(
                            durationStr(
                              Duration(
                                  microseconds: _duration.inMicroseconds - value.inMicroseconds),
                            ),
                            style: textStyleRegular.copyWith(fontSize: 12.sp),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          widget.message.id == null ? _buildLoading() : _buildPlayButton(),
        ],
      ),
    );
  }
}
