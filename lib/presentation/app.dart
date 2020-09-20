import 'package:chat_app/common/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/common/blocs/loading_bloc/loading_bloc.dart';
import 'package:chat_app/common/blocs/loading_bloc/loading_state.dart';
import 'package:chat_app/common/injector/injector.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/utils/screen_utils.dart';
import 'package:chat_app/presentation/features/authentication/screen/sign_in_screen.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/localized_app.dart';

class App extends StatelessWidget {
  // Global provider
  List<BlocProvider> _getProviders() => [
        BlocProvider<LoadingBloc>(
          create: (_) => Injector.resolve<LoadingBloc>(),
        ),
        BlocProvider<AuthBloc>(
          create: (_) => Injector.resolve<AuthBloc>(),
        )
      ];

  // Global bloc listener
  List<BlocListener> _getBlocListener(context) => [
        BlocListener<LoadingBloc, LoadingState>(
          listener: (context, state) {},
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final localizationDelegate = LocalizedApp.of(context).delegate;
    return MultiBlocProvider(
      providers: _getProviders(),
      child: MaterialApp(
        navigatorKey: Routes.instance.navigatorKey,
        title: 'Chat',
        onGenerateRoute: Routes.generateRoute,
        initialRoute: SignInScreen.route,
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          fontFamily: 'Avenir',
        ),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          localizationDelegate
        ],
        supportedLocales: localizationDelegate.supportedLocales,
        locale: localizationDelegate.currentLocale,
        builder: (context, widget) {
          ScreenUtil.init(context);
          return MultiBlocListener(
            listeners: _getBlocListener(context),
            child: widget,
          );
        },
      ),
    );
  }
}
