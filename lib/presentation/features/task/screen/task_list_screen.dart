import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/widgets/app_bar.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:chat_app/domain/entities/task_entity.dart';
import 'package:chat_app/presentation/features/task/screen/create_task.dart';
import 'package:chat_app/presentation/features/task/screen/task_detail.dart';
import 'package:chat_app/presentation/features/task/widgets/item_task.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_translate/flutter_translate.dart';

class TaskListScreen extends StatefulWidget {
  static const String router = '/task_list';
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Column(
        children: [
          AppBarWidget(
            onTapLeading: () => Routes.instance.pop(),
            center: Text(
              translate(StringConst.task),
              style: textStyleAppbar,
            ),
            trailing: GestureDetector(
              onTap: () => Routes.instance.navigate(CreateTaskScreen.router),
              child: SvgPicture.asset(
                IconConst.addTask,
                width: 20.w,
                height: 20.w,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(height: 15.w),
              itemCount: 10,
              itemBuilder: (context, index) {
                return ItemTask(
                  status: TaskEntity.checkTaskStatus(TaskEntity(status: 1).status),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
