import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/utils/screen_utils.dart';
import 'package:chat_app/domain/entities/task_entity.dart';
import 'package:chat_app/presentation/features/task/screen/create_task.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_translate/flutter_translate.dart';

class TaskOptionSheet extends StatelessWidget {
  final TaskEntity task;

  TaskOptionSheet({Key key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          ItemBottomSheet(
            label: translate(StringConst.editTask),
            onTap: () {
              Routes.instance.pop();
              Routes.instance.navigate(CreateTaskScreen.router, arguments: {
                'task': task
              });
            },
          ),
          ItemBottomSheet(
            label: translate(StringConst.reportTask),
            onTap: () {
              // hide bottom sheet
              // Routes.instance.pop();
              // Routes.instance.navigate(TaskReportScreen.router);
            },
          ),
          ItemBottomSheet(
            label: translate(StringConst.completedTask),
            onTap: () {},
          ),
          ItemBottomSheet(
            label: translate(StringConst.closeTask),
            onTap: () {},
          ),
          ItemBottomSheet(
            label: translate(StringConst.close),
            onTap: () => Routes.instance.pop(),
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}

class ItemBottomSheet extends StatelessWidget {
  final String label;
  final Function onTap;
  final Color color;

  const ItemBottomSheet({
    Key key,
    this.label,
    this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 50.h,
        child: Column(
          children: <Widget>[
            const Spacer(),
            Center(
              child: Text(
                '$label',
                style: textStyleLabel.copyWith(
                  color: color ?? AppColors.black,
                ),
              ),
            ),
            const Spacer(),
            color != null
                ? const SizedBox()
                : Container(
                    width: ScreenUtil.screenWidthDp,
                    height: 1.w,
                    color: AppColors.line,
                  ),
          ],
        ),
      ),
    );
  }
}
