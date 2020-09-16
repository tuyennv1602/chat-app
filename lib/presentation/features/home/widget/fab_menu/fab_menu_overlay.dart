import 'package:chat_app/presentation/features/home/widget/fab_menu/fab_menu_container.dart';
import 'package:flutter/material.dart';

class FabMenuOverlay {
  final BuildContext context;
  final GlobalKey<State<StatefulWidget>> keyItem;
  final Function onTapJoinConversation;
  final Function onTapCreateConversation;

  FabMenuOverlay(
    this.context, {
    @required this.keyItem,
    this.onTapCreateConversation,
    this.onTapJoinConversation,
  });

  OverlayEntry _overlayEntry;
  bool _opened = false;

  void show() {
    if (_opened) {
      _overlayEntry?.remove();
    }
    try {
      final RenderBox renderBox = keyItem.currentContext?.findRenderObject();
      if (renderBox != null) {
        _overlayEntry = _buildOverlayEntry(renderBox);
        Overlay.of(context).insert(_overlayEntry);
        _opened = true;
      }
    } catch (e, s) {
      _opened = false;
    }
  }

  void hide() {
    if (_opened) {
      _overlayEntry?.remove();
      _opened = false;
    }
  }

  OverlayEntry _buildOverlayEntry(RenderBox renderBox) {
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    return OverlayEntry(
      builder: (context) => FabMenuContainer(
        targetOffset: offset,
        targetSize: size,
        onTapCreate: onTapCreateConversation,
        onTapJoin: onTapJoinConversation,
      ),
    );
  }
}
