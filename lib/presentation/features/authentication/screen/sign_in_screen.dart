import 'package:chat_app/common/blocs/loading_bloc/loading_bloc.dart';
import 'package:chat_app/common/blocs/loading_bloc/loading_event.dart';
import 'package:chat_app/common/injector/injector.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  static const String route = '/sign_in';
  const SignInScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () async {
              Injector.resolve<LoadingBloc>().add(StartLoading());
              await Future.delayed(const Duration(seconds: 2));
              Injector.resolve<LoadingBloc>().add(FinishLoading());
            },
            child: const Text('Loading'),
          ),
        ],
      ),
    );
  }
}
