import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/common/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/common/injector/injector.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';

class GalleryPhotoScreen extends StatefulWidget {
  static const String route = '/gallery_photo';

  final MessageEntity message;
  final int index;

  const GalleryPhotoScreen({
    Key key,
    this.message,
    this.index,
  }) : super(key: key);

  @override
  _GalleryPhotoScreenState createState() => _GalleryPhotoScreenState();
}

class _GalleryPhotoScreenState extends State<GalleryPhotoScreen> {
  PageController pageController;
  int currentIndex;
  String _token;

  @override
  void initState() {
    _token = Injector.resolve<AuthBloc>().state.token;
    currentIndex = widget.index;
    pageController = PageController(initialPage: widget.index);
    super.initState();
  }

  PhotoViewGalleryPageOptions _buildPhoto(BuildContext context, int index) {
    // final item = widget.message.images[index];
    final item = '${widget.message.getMediaUrl}?token=$_token';
    return PhotoViewGalleryPageOptions(
      imageProvider: CachedNetworkImageProvider(item),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 1.1,
      heroAttributes: PhotoViewHeroAttributes(tag: item),
    );
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
            child: Column(
              children: [
                Container(
                  color: Colors.black,
                  height: 60.w,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.message.sender.nickname,
                                style: textStyleAppbar.copyWith(color: Colors.white),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: Text(
                                  '${widget.message.getFullCreatedTime}',
                                  style: TextStyle(color: Colors.white, fontSize: 13.sp),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 15.w),
                      //   child: Text(
                      //     '${currentIndex + 1}/${widget.message.images.length}',
                      //     style: textStyleRegular.copyWith(color: Colors.white),
                      //   ),
                      // )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.black,
                    child: PhotoViewGallery.builder(
                      builder: _buildPhoto,
                      scrollPhysics: const BouncingScrollPhysics(),
                      // itemCount: widget.message.images.length,
                      itemCount: 1,
                      backgroundDecoration: const BoxDecoration(color: Colors.black),
                      pageController: pageController,
                      onPageChanged: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
