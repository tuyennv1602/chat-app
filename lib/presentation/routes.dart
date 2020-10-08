import 'package:chat_app/common/navigation/fade_in_route.dart';
import 'package:chat_app/common/navigation/slide_left_route.dart';
import 'package:chat_app/common/navigation/slide_up_router.dart';
import 'package:chat_app/presentation/features/conversation/screen/conversatiton_screen.dart';
import 'package:chat_app/presentation/features/conversation/screen/gallery_photo_screen.dart';
import 'package:chat_app/presentation/features/conversation/screen/map_screen.dart';
import 'package:chat_app/presentation/features/conversation/screen/option_screen.dart';
import 'package:chat_app/presentation/features/conversation/screen/video_player_screen.dart';
import 'package:chat_app/presentation/features/home/screen/create_room_screen.dart';
import 'package:chat_app/presentation/features/authentication/screen/active_account_screen.dart';
import 'package:chat_app/presentation/features/authentication/screen/forgot_password_success_screen.dart';
import 'package:chat_app/presentation/features/home/screen/home_screen.dart';
import 'package:chat_app/presentation/features/select_member/screen/select_member_screen.dart';
import 'package:flutter/material.dart';
import 'features/authentication/screen/forgot_password.dart';
import 'features/authentication/screen/sign_in_screen.dart';
import 'features/authentication/screen/sign_up_screen.dart';

class Routes {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  factory Routes() => _instance;

  Routes._internal();

  static final Routes _instance = Routes._internal();

  static Routes get instance => _instance;

  BuildContext get currentContext => navigatorKey.currentContext;

  Future<dynamic> navigate(String routeName, {dynamic arguments}) async {
    await Future.delayed(const Duration(milliseconds: 5));
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateAndRemove(
    String routeName, {
    dynamic arguments,
  }) async {
    await Future.delayed(const Duration(milliseconds: 5));
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
    await Future.delayed(const Duration(milliseconds: 5));
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
        return FadeInRoute(widget: SignInScreen());
      case SignUpScreen.route:
        return SlideLeftRoute(widget: SignUpScreen());
      case ForgotPasswordScreen.route:
        return SlideLeftRoute(widget: ForgotPasswordScreen());
      case HomeScreen.route:
        return FadeInRoute(widget: HomeScreen());
      case CreateRoomScreen.route:
        return SlideLeftRoute(widget: CreateRoomScreen());
      case SelectMemberScreen.route:
        return SlideLeftRoute(widget: SelectMemberScreen());
      case ForgotPasswordSuccessScreen.router:
        return FadeInRoute(widget: ForgotPasswordSuccessScreen());
      case ActiveAccountScreen.route:
        final Map arguments = settings.arguments;
        return FadeInRoute(
          widget: ActiveAccountScreen(
            email: arguments['email'],
            name: arguments['name'],
          ),
        );
      case ConversationScreen.route:
        return SlideLeftRoute(widget: ConversationScreen());
      case GalleryPhotoScreen.route:
        final Map arguments = settings.arguments;
        return SlideUpRoute(
          widget: GalleryPhotoScreen(
            message: arguments['message'],
            index: arguments['index'],
          ),
        );
      case VideoPlayerScreen.route:
        final Map arguments = settings.arguments;
        return SlideUpRoute(
          widget: VideoPlayerScreen(arguments['message']),
        );
      case OptionScreen.route:
        return SlideLeftRoute(widget: OptionScreen());
      case MapScreen.route:
        return SlideLeftRoute(widget: MapScreen());
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
