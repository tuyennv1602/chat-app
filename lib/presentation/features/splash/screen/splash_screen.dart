import 'package:chat_app/common/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/common/blocs/auth_bloc/auth_event.dart';
import 'package:chat_app/common/blocs/auth_bloc/auth_state.dart';
import 'package:chat_app/common/constants/images.dart';
import 'package:chat_app/common/injector/injector.dart';
import 'package:chat_app/common/utils/screen_utils.dart';
import 'package:chat_app/presentation/features/authentication/screen/sign_in_screen.dart';
import 'package:chat_app/presentation/features/home/screen/home_screen.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SplashScreen extends StatelessWidget {
  static const String route = '/splash';

  SplashScreen() {
    Injector.resolve<AuthBloc>().add(CheckAuthEvent());
    // _testSocket();
  }

  void _testSocket() {
    final socket = io('http://54.249.191.109:5000/chat', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'extraHeaders': {
        'token':
            'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MDQ5ODA2MjAsImVtYWlsIjoidGVzdGVyM0BnbWFpbC5jb20ifQ.4s0W3SMciPl4yAtqaAFAWpi_GpXS9ZuJ7od-JpljGoc',
        'room': 1,
      }
    });
    socket
      ..on('connect', (_) {
        debugPrint('>>>>>>>connect');
        socket.emit('joined ', {});
      })
      ..on('connecting', (_) {
        debugPrint('>>>>>>>connecting');
      })
      ..on('error', (_) {
        debugPrint('>>>>>>>error');
      })
      ..on('disconnect', (_) {
        debugPrint('>>>>>>>disconnect');
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            Future.delayed(const Duration(seconds: 1)).then(
              (_) => Routes.instance.navigateAndRemove(HomeScreen.route),
            );
          }
          if (state is UnAuthenticatedState || state is ErroredAuthState) {
            Future.delayed(const Duration(seconds: 3)).then(
              (_) => Routes.instance.navigateAndRemove(SignInScreen.route),
            );
          }
        },
        child: Center(
          child: SizedBox(
            width: ScreenUtil.screenWidthDp / 2,
            height: ScreenUtil.screenWidthDp / 2,
            child: Image.asset(
              ImageConst.splash,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
