import 'dart:io';
import 'dart:ui';

import 'package:chat_app/common/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/common/blocs/auth_bloc/auth_event.dart';
import 'package:chat_app/common/blocs/auth_bloc/auth_state.dart';
import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/images.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/injector/injector.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/utils/alert_utils.dart';
import 'package:chat_app/common/utils/screen_utils.dart';
import 'package:chat_app/common/widgets/attach_item.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:chat_app/common/widgets/circle_avatar.dart';
import 'package:chat_app/common/widgets/custom_alert.dart';
import 'package:chat_app/presentation/features/authentication/screen/sign_in_screen.dart';
import 'package:chat_app/presentation/features/profile/bloc/avatar_bloc/update_avatar_bloc.dart';
import 'package:chat_app/presentation/features/profile/bloc/avatar_bloc/update_avatar_event.dart';
import 'package:chat_app/presentation/features/profile/bloc/avatar_bloc/update_avatar_state.dart';
import 'package:chat_app/presentation/features/profile/widget/item_info.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class MyProfileScreen extends StatelessWidget {
  static const String route = '/my-profile';

  AuthBloc _authBloc;
  UpdateAvatarBloc _avatarBloc;

  MyProfileScreen() {
    _authBloc = Injector.resolve<AuthBloc>();
    _avatarBloc = Injector.resolve<UpdateAvatarBloc>();
  }

  Future<void> _pickImages() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      _avatarBloc.add(
        UpdateAvatarEvent(
          fileName: '${_authBloc.state.user.id}_',
          filePath: file.path,
        ),
      );
    }
  }

  Future<void> _captureImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      _avatarBloc.add(
        UpdateAvatarEvent(
          fileName: _authBloc.state.user.id.toString(),
          filePath: file.path,
        ),
      );
    }
  }

  void _chooseImage(context) => showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        barrierColor: AppColors.overlay,
        builder: (BuildContext context) => Container(
          padding: EdgeInsets.all(20.w),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Wrap(
            children: [
              SafeArea(
                top: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AttachItem(
                      icon: IconConst.mountain,
                      title: translate(StringConst.gallery),
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickImages();
                      },
                    ),
                    SizedBox(width: 30.w),
                    AttachItem(
                      icon: IconConst.camera,
                      title: translate(StringConst.camera),
                      onTap: () {
                        Navigator.of(context).pop();
                        _captureImage();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildUpdatingAvatar(String filePath) => ClipRRect(
        borderRadius: BorderRadius.circular(78.w / 2),
        child: Container(
          width: 78.w,
          height: 78.w,
          color: Colors.white,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.file(
                  File(filePath),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Image.asset(
                      ImageConst.circleLoading,
                      height: 25,
                      width: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _avatarBloc,
      child: BaseScaffold(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (c, authState) {
            if (authState is UnAuthenticatedState) {
              Navigator.pushNamedAndRemoveUntil(context, SignInScreen.route, (route) => false);
            }
          },
          builder: (_, authState) => Stack(
            children: [
              Positioned.fill(
                child: Column(
                  children: [
                    Container(
                      height: ScreenUtil.statusBarHeight + 90.w,
                      padding: EdgeInsets.only(top: ScreenUtil.statusBarHeight),
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 15,
                            offset: Offset(0, 2),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.w),
                          bottomRight: Radius.circular(20.w),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              width: 60.w,
                              height: 60.w,
                              padding: EdgeInsets.all(20.w),
                              child: SvgPicture.asset(IconConst.back),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40.w, bottom: 20.w),
                      child: Text(
                        authState.user.nickname,
                        style: textStyleAppbar,
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ItemInfoWidget(
                              icon: IconConst.name,
                              title: 'MQN: ${authState.user.code}',
                            ),
                            ItemInfoWidget(
                              icon: IconConst.code,
                              title: authState.user.fullname,
                            ),
                            ItemInfoWidget(
                              icon: IconConst.mail,
                              title: authState.user.email,
                            ),
                            ItemInfoWidget(
                              icon: IconConst.telephone,
                              title: authState.user.phoneNumber,
                            ),
                            ItemInfoWidget(
                              icon: IconConst.pin,
                              title: authState.user.phoneNumber,
                            ),
                            ItemInfoWidget(
                              icon: IconConst.padlock,
                              title: translate(StringConst.changePassword),
                              onTap: () {},
                            ),
                            ItemInfoWidget(
                              icon: IconConst.logout,
                              title: translate(StringConst.logout),
                              textColor: AppColors.red,
                              onTap: () => _authBloc.add(SignedOutEvent()),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: ScreenUtil.bottomBarHeight + 5, top: 5),
                      child: const Text('Phiên bản: 1.0.0'),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: ScreenUtil.statusBarHeight + 40.w,
                left: 0,
                right: 0,
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 80.w,
                        height: 80.w,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadow,
                              blurRadius: 10,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: BlocConsumer<UpdateAvatarBloc, UpdateAvatarState>(
                          listener: (_, state) {
                            if (state is ErrorUpdateAvatarState) {
                              AlertUtil.show(
                                context,
                                child: CustomAlertWidget.error(
                                  title: translate(StringConst.notification),
                                  message: state.message,
                                ),
                              );
                            }
                          },
                          builder: (_, state) {
                            if (state is UpdatingAvatarState) {
                              return _buildUpdatingAvatar(state.filePath);
                            }
                            return CircleAvatarWidget(
                              size: 78,
                              source: authState.user.fullAvatar,
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => _chooseImage(context),
                          child: Container(
                            width: 28.w,
                            height: 28.w,
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              border: Border.all(
                                width: 1.5,
                                color: Colors.white,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              IconConst.camera,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
