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
    _progressDialog = ProgressDialog(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: BlocListener<LoadingBloc, LoadingState>(
        listener: (context, state) {
          if (state is Loading) {
            _progressDialog.show();
          }
          if (state is Loaded) {
            _progressDialog.hide();
          }
        },
        child: widget.child,
      ),
    );
  }
}
