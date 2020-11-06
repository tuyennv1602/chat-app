import 'dart:io';

import 'package:chat_app/common/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/injector/injector.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/utils/alert_utils.dart';
import 'package:chat_app/common/widgets/animated_button.dart';
import 'package:chat_app/common/widgets/custom_alert.dart';
import 'package:chat_app/common/widgets/load_more_loading.dart';
import 'package:chat_app/common/widgets/loading_widget.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/presentation/features/conversation/bloc/message_bloc/message_bloc.dart';
import 'package:chat_app/presentation/features/conversation/bloc/message_bloc/message_event.dart';
import 'package:chat_app/presentation/features/conversation/bloc/message_bloc/message_state.dart';
import 'package:chat_app/presentation/features/conversation/bloc/socket_bloc/socket_bloc.dart';
import 'package:chat_app/presentation/features/conversation/bloc/socket_bloc/socket_event.dart';
import 'package:chat_app/common/widgets/attach_item.dart';
import 'package:chat_app/presentation/features/conversation/widget/message_bubble.dart';
import 'package:chat_app/presentation/features/conversation/widget/send_file_bubble.dart';
import 'package:chat_app/presentation/features/conversation/widget/sender_detail.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChatPage extends StatefulWidget {
  final MessageBloc messageBloc;
  final SocketBloc socketBloc;
  final int roomId;

  const ChatPage({
    Key key,
    this.messageBloc,
    this.socketBloc,
    this.roomId,
  }) : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageCtrl = TextEditingController();
  final RefreshController _refershController = RefreshController(initialRefresh: false);
  final ValueNotifier<bool> _inputMessageNotifier = ValueNotifier(false);
  final ValueNotifier<bool> _attachNotifier = ValueNotifier(false);
  static final GlobalKey<AnimatedButtonWidgetState> _keyFabButton = GlobalKey();
  int userId;

  @override
  void initState() {
    userId = Injector.resolve<AuthBloc>().state.user.id;
    messageCtrl.addListener(() {
      _inputMessageNotifier.value = messageCtrl.text.isNotEmpty;
    });
    super.initState();
  }

  @override
  void dispose() {
    _refershController.dispose();
    _inputMessageNotifier.dispose();
    _attachNotifier.dispose();
    super.dispose();
  }

  void _hideAttachButton() {
    _keyFabButton?.currentState?.close();
    _attachNotifier.value = false;
  }

  MessageModel get createMessage => MessageModel(
        sender: UserModel(
          id: userId,
        ),
        createdAt: DateTime.now().toIso8601String(),
      );

  Future<void> _pickVideo() async {
    final result =
        await FilePicker.platform.pickFiles(type: FileType.video, allowCompression: true);
    if (result != null) {
      final file = result.files.first;
      widget.messageBloc.add(
        NewMessageEvent(
          createMessage
            ..fileExtension = result.files[0].extension
            ..content = file.path
            ..type = 3,
        ),
      );
    }
  }

  Future<void> _pickAudio() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null) {
      final file = result.files.first;
      widget.messageBloc.add(
        NewMessageEvent(
          createMessage
            ..fileExtension = result.files[0].extension
            ..content = file.path
            ..type = 4,
        ),
      );
    }
  }

  Future<void> _pickImages() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false, allowCompression: true);
    if (result != null) {
      final file = File(result.paths[0]);
      widget.messageBloc.add(
        NewMessageEvent(
          createMessage
            ..fileExtension = result.files[0].extension
            ..content = file.path
            ..type = 2,
        ),
      );
    }
  }

  Future<void> _captureImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera, imageQuality: 50);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      widget.messageBloc.add(
        NewMessageEvent(
          createMessage
            ..fileExtension = 'jpg'
            ..content = file.path
            ..type = 2,
        ),
      );
    }
  }

  TextStyle get _defaultTextStyle => TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
        color: AppColors.black,
      );

  void _loadMoreMessage() {
    widget.messageBloc.add(LoadMoreMessagesEvent(widget.roomId));
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardAvoider(
      child: Column(
        children: [
          Expanded(
            child: Listener(
              onPointerDown: (_) => FocusScope.of(context).requestFocus(FocusNode()),
              child: BlocConsumer<MessageBloc, MessageState>(
                listener: (_, state) {
                  if (state is LoadedMessagesState || state is ErroredMessageState) {
                    _refershController?.loadComplete();
                  }
                  if (state is ErroredMessageState) {
                    AlertUtil.show(
                      context,
                      child: CustomAlertWidget.error(
                        title: translate(StringConst.notification),
                        message: state.error,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is LoadingMessagesState) {
                    return LoadingWidget();
                  }
                  return SmartRefresher(
                    enablePullUp: state.canLoadMore,
                    enablePullDown: false,
                    controller: _refershController,
                    footer: const LoadMoreLoading(),
                    onLoading: _loadMoreMessage,
                    child: ListView.builder(
                      reverse: true,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final _message = state.messages[index];
                        final _previous = index == 0 ? null : state.messages[index - 1];
                        final _next =
                            index == state.messages.length - 1 ? null : state.messages[index + 1];
                        if (_message.id == null && _message.contentType != MessageType.text) {
                          return SendFileBubble(
                            message: _message,
                            previous: _next,
                            next: _previous,
                            socketBloc: widget.socketBloc,
                          );
                        }
                        return MessageBubble(
                          message: _message,
                          previousMessage: _next,
                          nextMessage: _previous,
                          showSenderName: true,
                          onTapSender: (sender) => AlertUtil.show(
                            context,
                            child: SenderDetailWidget(
                              user: sender,
                            ),
                            begin: const Offset(-1, 0),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5.w),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 15,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.w),
                  child: AnimatedButtonWidget(
                    key: _keyFabButton,
                    buttonSize: 25.w,
                    onTap: (isOpened) {
                      FocusScope.of(context).unfocus();
                      _attachNotifier.value = !isOpened;
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 15.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.line),
                      borderRadius: BorderRadius.circular(38.w / 2),
                    ),
                    child: CupertinoTextField(
                      style: _defaultTextStyle,
                      textAlignVertical: TextAlignVertical.center,
                      placeholderStyle: _defaultTextStyle.copyWith(color: AppColors.warmGrey),
                      padding: EdgeInsets.zero,
                      cursorColor: AppColors.primaryColor,
                      cursorWidth: 1.5,
                      placeholder: translate(StringConst.inputMessage),
                      autocorrect: false,
                      enableSuggestions: false,
                      maxLines: 4,
                      minLines: 1,
                      textInputAction: TextInputAction.newline,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent),
                      ),
                      controller: messageCtrl,
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: _inputMessageNotifier,
                  builder: (context, enable, child) => IconButton(
                    iconSize: 25.w,
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    icon: SvgPicture.asset(
                      IconConst.send,
                      color: enable ? AppColors.primaryColor : AppColors.grey,
                    ),
                    onPressed: () {
                      if (enable) {
                        widget.socketBloc.add(
                          SendMessageEvent(
                            message: createMessage
                              ..type = 1
                              ..content = messageCtrl.text.trim(),
                          ),
                        );
                        messageCtrl.text = '';
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          ValueListenableBuilder(
            valueListenable: _attachNotifier,
            builder: (context, isOpen, child) {
              if (isOpen) {
                return Container(
                  height: 70.w,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: AttachItem(
                          icon: IconConst.mountain,
                          title: translate(StringConst.gallery),
                          onTap: () {
                            _hideAttachButton();
                            _pickImages();
                          },
                        ),
                      ),
                      Expanded(
                        child: AttachItem(
                          icon: IconConst.camera,
                          title: translate(StringConst.camera),
                          onTap: () {
                            _hideAttachButton();
                            _captureImage();
                          },
                        ),
                      ),
                      Expanded(
                        child: AttachItem(
                          icon: IconConst.video,
                          title: translate(StringConst.video),
                          onTap: () {
                            _hideAttachButton();
                            _pickVideo();
                          },
                        ),
                      ),
                      Expanded(
                        child: AttachItem(
                          icon: IconConst.audio,
                          title: translate(StringConst.audio),
                          onTap: () {
                            _hideAttachButton();
                            _pickAudio();
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}
