import 'dart:convert';
import 'dart:io';

import 'package:chat_app/common/injector/injector.dart';
import 'package:chat_app/common/network/http.dart';
import 'package:chat_app/presentation/app.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/localization_delegate.dart';

import 'common/blocs/supervisor_bloc/supervisor_bloc.dart';

dynamic _parseAndDecode(String response) => jsonDecode(response);

dynamic parseJson(String text) => compute(_parseAndDecode, text);

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  // init kiwi
  Injector.setup();
  Bloc.observer = SupervisorBloc();

  // set up multiple languages
  final delegate = await LocalizationDelegate.create(
    fallbackLocale: 'vi',
    supportedLocales: ['vi'],
  );
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  HttpOverrides.global = MyHttpOverrides();
  dio.interceptors.add(logInterceptor);
  // ignore: avoid_as
  (dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;

  runApp(LocalizedApp(delegate, App()));
}
