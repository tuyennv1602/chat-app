import 'dart:io';

import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/presentation/features/conversation/bloc/upload_file_bloc/upload_file_bloc.dart';
import 'package:chat_app/presentation/features/conversation/bloc/upload_file_bloc/upload_file_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendingPlaceHolder extends StatelessWidget {
  final String filePath;

  SendingPlaceHolder({Key key, @required this.filePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.file(
            File(filePath),
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        BlocBuilder<UploadFileBloc, UploadFileState>(
          builder: (_, state) => Visibility(
            visible: state is ErroredUploadFileState,
            child: SizedBox.expand(
              child: Container(
                color: AppColors.messageBox,
                child: const Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
