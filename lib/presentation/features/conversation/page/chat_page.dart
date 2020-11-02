import 'dart:io';

import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/widgets/animated_button.dart';
import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:chat_app/presentation/features/conversation/bloc/message_bloc/message_bloc.dart';
import 'package:chat_app/presentation/features/conversation/bloc/message_bloc/message_state.dart';
import 'package:chat_app/presentation/features/conversation/bloc/socket_bloc/socket_bloc.dart';
import 'package:chat_app/presentation/features/conversation/bloc/socket_bloc/socket_event.dart';
import 'package:chat_app/presentation/features/conversation/widget/attach_item.dart';
import 'package:chat_app/presentation/features/conversation/widget/message_bubble.dart';
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

  const ChatPage({
    Key key,
    this.messageBloc,
    this.socketBloc,
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

  final List<MessageEntity> mockChats = [
    MessageEntity(
      id: '11',
      sender: UserEntity(id: 3, nickname: 'User 3', fullname: 'Nguyen Van B'),
      type: 4,
      audioUrl: 'https://luan.xyz/files/audio/ambient_c_motion.mp3',
      createdAt: 1601447374,
    ),
    MessageEntity(
      id: '10',
      sender: UserEntity(id: 3, nickname: 'User 3', fullname: 'Nguyen Van B'),
      type: 3,
      videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      createdAt: 1601447374,
    ),
    MessageEntity(
      id: '9',
      sender: UserEntity(id: 3, nickname: 'User 3', fullname: 'Nguyen Van B'),
      type: 2,
      images: [
        'https://www.tooktrip.com/en/upload/save_image/05270953_5ecdd62681be3.jpg',
        'https://cdn.pixabay.com/photo/2016/10/18/21/22/california-1751455__340.jpg',
        'https://www.visitlagunabeach.com/imager/s3-us-west-1_amazonaws_com/laguna-craft/craft/Victoria-beach-scs_2632d877b3d4fc81e8192bac4d0bf9b7.jpg'
      ],
      createdAt: 1601447374,
    ),
    MessageEntity(
      id: '8',
      sender: UserEntity(id: 3, nickname: 'User 3', fullname: 'Nguyen Van B'),
      type: 2,
      images: [
        'https://www.tooktrip.com/en/upload/save_image/05270953_5ecdd62681be3.jpg',
        'https://cdn.pixabay.com/photo/2016/10/18/21/22/california-1751455__340.jpg'
      ],
      createdAt: 1601447374,
    ),
    MessageEntity(
      id: '6',
      sender: UserEntity(id: 3, nickname: 'User 3', fullname: 'Nguyen Van B'),
      content: 'Hey Trung, how are you today?',
      createdAt: 1601447374,
    ),
    MessageEntity(
      id: '5',
      sender: UserEntity(id: 1, nickname: 'tunk', fullname: 'Nguyen Khac Tu'),
      content: 'Thanks',
      createdAt: 1601341500,
    ),
    MessageEntity(
      id: '4',
      sender: UserEntity(id: 1, nickname: 'tunk', fullname: 'Nguyen Khac Tu'),
      content: 'Can you wait for me before heading to the office?',
      createdAt: 1601341200,
    ),
    MessageEntity(
      id: '3',
      sender: UserEntity(id: 5, nickname: 'User 1', fullname: 'Nguyen Van A'),
      content: 'I can’t wait to discuss it with someone, but I don’t want to spoiler it…',
      createdAt: 1601276520,
    ),
    MessageEntity(
      id: '2',
      sender: UserEntity(id: 5, nickname: 'User 1', fullname: 'Nguyen Van A'),
      type: 2,
      images: ['https://www.tooktrip.com/en/upload/save_image/05270953_5ecdd62681be3.jpg'],
      createdAt: 1601276520,
    ),
    MessageEntity(
      id: '1',
      sender: UserEntity(id: 5, nickname: 'User 1', fullname: 'Nguyen Van A'),
      content: 'Did you see the Game of Thomes last night?',
      createdAt: 1601276400,
    ),
  ];

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

  Future<void> _pickVideo() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null) {
      final file = result.files.first;
      debugPrint('video path: ${file.path}');
    }
  }

  Future<void> _pickAudio() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null) {
      final file = result.files.first;
      debugPrint('audio path: ${file.path}');
    }
  }

  Future<void> _pickImages() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: true);
    if (result != null) {
      final files = result.paths.map((path) => File(path)).toList();
      debugPrint('images path: ${files.length}');
    }
  }

  Future<void> _captureImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      debugPrint('image path: ${file.path}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardAvoider(
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<MessageBloc, MessageState>(
              builder: (context, state) => SmartRefresher(
                enablePullUp: true,
                enablePullDown: false,
                controller: _refershController,
                child: ListView.builder(
                  reverse: true,
                  padding: EdgeInsets.only(
                    left: 15.w,
                    right: 15.w,
                  ),
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final _previous = index == 0 ? null : state.messages[index - 1];
                    final _next =
                        index == state.messages.length - 1 ? null : state.messages[index + 1];
                    return MessageBubble(
                      message: state.messages[index],
                      previousMessage: _next,
                      nextMessage: _previous,
                      showSenderName: true,
                    );
                  },
                ),
              ),
            ),
          ),
          Container(
            height: 55.w,
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
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
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
                    height: 38.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.line),
                      borderRadius: BorderRadius.circular(38.w / 2),
                    ),
                    child: CupertinoTextField(
                      style: textStyleInput,
                      textAlignVertical: TextAlignVertical.center,
                      placeholderStyle: textStyleInput.copyWith(color: AppColors.warmGrey),
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      cursorColor: AppColors.primaryColor,
                      cursorWidth: 1.5,
                      placeholder: translate(StringConst.inputMessage),
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent),
                      ),
                      controller: messageCtrl,
                      onChanged: (value) {
                        _inputMessageNotifier.value = value.isNotEmpty;
                      },
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: _inputMessageNotifier,
                  builder: (context, enable, child) => IconButton(
                    iconSize: 25.w,
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
                    icon: SvgPicture.asset(
                      IconConst.send,
                      color: enable ? AppColors.primaryColor : AppColors.grey,
                    ),
                    onPressed: () {
                      widget.socketBloc.add(SendMessageEvent(type: 1, content: messageCtrl.text));
                      messageCtrl.text = '';
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
