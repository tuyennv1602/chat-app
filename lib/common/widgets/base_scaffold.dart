import 'package:chat_app/common/blocs/loading_bloc/loading_bloc.dart';
import 'package:chat_app/common/blocs/loading_bloc/loading_state.dart';
import 'package:chat_app/common/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';

class BaseScaffold extends StatelessWidget {
  final Widget child;
  final bool dismissKeyboard;

  BaseScaffold({
    Key key,
    @required this.child,
    this.dismissKeyboard = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingBloc, LoadingState>(
      builder: (context, state) => WillPopScope(
        onWillPop: () async => state is Loaded,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.white,
          body: Listener(
            onPointerDown: (_) =>
                dismissKeyboard ? FocusScope.of(context).requestFocus(FocusNode()) : null,
            child: Stack(
              children: [
                Positioned.fill(
                  child: child,
                ),
                Positioned.fill(
                  child: Visibility(
                    visible: state is Loading,
                    child: Container(
                      color: Colors.black.withOpacity(0.4),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.w),
                          child: Container(
                            width: 50.w,
                            height: 50.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25.w),
                            ),
                            child: Center(child: Image.asset(ImageConst.loading)),
                          ),
                        ),
                      ),
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
