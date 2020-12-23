import 'package:chat_app/common/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/injector/injector.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/widgets/circle_avatar.dart';
import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:chat_app/presentation/features/conversation/widget/audio_box.dart';
import 'package:chat_app/presentation/features/conversation/widget/image_box.dart';
import 'package:chat_app/presentation/features/conversation/widget/text_box.dart';
import 'package:chat_app/presentation/features/conversation/widget/video_box.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_svg/svg.dart';

class MessageBubble extends StatefulWidget {
  final MessageEntity message;
  final MessageEntity nextMessage;
  final MessageEntity previousMessage;
  final bool showSenderName;
  final Function(UserEntity sender) onTapSender;

  const MessageBubble({
    Key key,
    this.message,
    this.nextMessage,
    this.previousMessage,
    this.showSenderName = false,
    this.onTapSender,
  }) : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<MessageBubble> with AutomaticKeepAliveClientMixin<MessageBubble> {
  bool isShowTime = false;
  UserEntity _currentUser;
  String _token;

  @override
  void initState() {
    super.initState();
    _currentUser = Injector.resolve<AuthBloc>().state.user;
    _token = Injector.resolve<AuthBloc>().state.token;
  }

  bool get _isNextBySender => widget.message.sender.id == widget?.nextMessage?.sender?.id;
  bool get _isMine => _currentUser?.id == widget.message.sender.id;
  bool get _isPreviousDiff =>
      widget.previousMessage == null ||
      widget.message.getCreatedAt.difference(widget.previousMessage.getCreatedAt).inDays != 0;
  bool get _isNextDiff =>
      widget.nextMessage != null &&
      widget.message.getCreatedAt.difference(widget.nextMessage.getCreatedAt).inDays != 0;

  Widget _renderAvatar() {
    if (_isNextBySender) {
      return SizedBox(width: _isMine ? 0 : 35.w);
    }
    if (_isMine) {
      return const SizedBox();
    }
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: CircleAvatarWidget(
        source: widget.message.sender.fullAvatar,
        size: 25,
        onTap: () => widget.onTapSender?.call(widget.message.sender),
      ),
    );
  }

  Widget _renderSender() => Visibility(
        visible: widget.showSenderName && !_isNextBySender && !_isMine,
        child: Padding(
          padding: EdgeInsets.only(left: 35.w),
          child: Text(
            widget.message?.sender?.nickname ?? '',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: AppColors.greyText,
              fontSize: 11.sp,
            ),
          ),
        ),
      );

  Widget _renderVerticalLine() => Container(
        color: AppColors.line,
        height: 0.5,
      );

  Widget _renderSeperator() => Visibility(
      visible: _isPreviousDiff,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 10.w),
        child: Row(
          children: [
            Expanded(
              child: _renderVerticalLine(),
            ),
            Expanded(
              child: Text(
                widget.message.getCreatedDay,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.warmGrey,
                ),
              ),
            ),
            Expanded(
              child: _renderVerticalLine(),
            ),
          ],
        ),
      ));

  EdgeInsets _itemMargin() {
    if (_isNextDiff) {
      return null;
    }
    return EdgeInsets.only(bottom: _isNextBySender ? 3.w : 15.w);
  }

  Widget _getLeftTime() => Visibility(
        visible: _isMine,
        child: Expanded(
          child: isShowTime
              ? Padding(
                  padding: EdgeInsets.only(right: 5.w),
                  child: Text(
                    widget.message.getCreatedTime,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.warmGrey,
                    ),
                  ),
                )
              : const SizedBox(),
        ),
      );

  Widget _getRightTime() => Visibility(
        visible: !_isMine,
        child: Expanded(
          child: isShowTime
              ? Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: Text(
                    widget.message.getCreatedTime,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.warmGrey,
                    ),
                  ),
                )
              : const SizedBox(),
        ),
      );

  Widget _renderContent() {
    switch (widget.message.contentType) {
      case MessageType.image:
        return ImageBox(
          message: widget.message,
          isMine: _isMine,
          isNextBySender: _isNextBySender,
          token: _token,
        );
      case MessageType.video:
        return VideoBox(
          message: widget.message,
          isMine: _isMine,
          isNextBySender: _isNextBySender,
          token: _token,
        );
      case MessageType.audio:
        return AudioBox(
          message: widget.message,
          isMine: _isMine,
          isNextBySender: _isNextBySender,
          token: _token,
        );
      default:
        return TextBox(
          message: widget.message,
          isMine: _isMine,
          isNextBySender: _isNextBySender,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          isShowTime = !isShowTime;
        });
      },
      child: Container(
        margin: _itemMargin(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _renderSeperator(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _renderAvatar(),
                _getLeftTime(),
                Visibility(
                  visible: widget.message.id == null,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: SvgPicture.asset(
                      IconConst.sending,
                      width: 13.w,
                      height: 13.w,
                      color: AppColors.warmGrey,
                    ),
                  ),
                ),
                _renderContent(),
                _getRightTime(),
              ],
            ),
            _renderSender(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
