import 'package:chat_app/common/blocs/loading_bloc/loading_bloc.dart';
import 'package:chat_app/common/blocs/loading_bloc/loading_state.dart';
import 'package:chat_app/common/widgets/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseScaffold extends StatefulWidget {
  final Widget child;

  BaseScaffold({Key key, @required this.child}) : super(key: key);

  @override
  _BaseScaffoldState createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  ProgressDialog _progressDialog;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: BlocListener<LoadingBloc, LoadingState>(
        listener: (context, state) {
          _progressDialog ??= ProgressDialog(context);
          if (state is Loading) {
            _progressDialog.show();
          }
          if (state is Loaded) {
            _progressDialog.hide();
          }
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.deferToChild,
          child: widget.child,
        ),
      ),
    );
  }
}
