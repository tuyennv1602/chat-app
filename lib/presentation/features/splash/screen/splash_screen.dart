import 'package:chat_app/common/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/common/blocs/auth_bloc/auth_event.dart';
import 'package:chat_app/common/blocs/auth_bloc/auth_state.dart';
import 'package:chat_app/common/injector/injector.dart';
import 'package:chat_app/common/widgets/loading_widget.dart';
import 'package:chat_app/presentation/features/authentication/screen/sign_in_screen.dart';
import 'package:chat_app/presentation/features/home/screen/home_screen.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  static const String route = '/splash';

  SplashScreen() {
    Injector.resolve<AuthBloc>().add(CheckAuthEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            Routes.instance.navigateAndRemove(HomeScreen.route);
          }
          if (state is UnAuthenticatedState || state is ErroredAuthState) {
            Routes.instance.navigateAndRemove(SignInScreen.route);
          }
        },
        child: LoadingWidget(),
      ),
    );
  }
}