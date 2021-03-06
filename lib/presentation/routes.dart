import 'package:chat_app/common/navigation/fade_in_route.dart';
import 'package:chat_app/presentation/features/authentication/screen/sign_in_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  factory Routes() => _instance;

  Routes._internal();

  static final Routes _instance = Routes._internal();

  static Routes get instance => _instance;

  BuildContext get currentContext => navigatorKey.currentContext;

  Future<dynamic> navigate(String routeName, {dynamic arguments}) async =>
      navigatorKey.currentState.pushNamed(routeName, arguments: arguments);

  Future<dynamic> navigateAndRemove(
    String routeName, {
    dynamic arguments,
  }) async {
    return navigatorKey.currentState.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  Future<dynamic> navigateAndReplace(
    String routeName, {
    dynamic arguments,
  }) async {
    return navigatorKey.currentState.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  void pop({dynamic result}) {
    if (navigatorKey.currentState.canPop()) {
      navigatorKey.currentState.pop(result);
    }
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SignInScreen.route:
        return FadeInRoute(widget: const SignInScreen());
      default:
        return _emptyRoute(settings);
    }
  }

  static MaterialPageRoute _emptyRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Center(
              child: Text(
                'Back',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
        body: Center(
          child: Text('No path for ${settings.name}'),
        ),
      ),
    );
  }
}
