import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/domain/entities/task_entity.dart';
import 'package:chat_app/presentation/features/task/screen/task_detail.dart';
import 'package:chat_app/presentation/features/task/widgets/item_status.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:chat_app/common/extensions/date_time_ext.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ItemTask extends StatelessWidget {
  final TaskEntity task;
  int size = 20;
  ItemTask({Key key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Routes.instance.navigate(TaskDetailScreen.route),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 15,
              offset: Offset(0, 2),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10.w),
          ),
        ),
        child: Row(
          children: [
            Column(
              children: [
                SvgPicture.asset(
                  IconConst.pending,
                  width: size.w,
                  height: size.w,
                  color: AppColors.yellow,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5.w),
                  width: 1.w,
                  height: 28.h,
                  color: task.checkTaskStatus == TaskStatus.none
                      ? AppColors.yellow
                      : task.checkTaskStatus == TaskStatus.done
                          ? AppColors.primaryColor
                          : AppColors.red,
                ),
                ItemStatusWidget(
                  status: task.checkTaskStatus,
                ),
              ],
            ),
            Container(
              width: 1.w,
              height: 90.w,
              color: AppColors.line,
              margin: EdgeInsets.symmetric(horizontal: 12.w),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.content ?? '',
                    style: textStyleLabel,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '${translate(StringConst.time)}: ${task.startTime.toFormat('HH:mm dd/MM') ?? ''} - ${task.endTime.toFormat('HH:mm dd/MM') ?? ''}',
                    style: textStyleRegular,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    '${translate(StringConst.boss)}: ${task.leader.fullname ?? ''}',
                    style: textStyleRegular,
                  ),
                  SizedBox(height: 10.h),
                  // SizedBox(
                  //   height: 26.w,
                  //   child: ListView.separated(
                  //     scrollDirection: Axis.horizontal,
                  //     separatorBuilder: (BuildContext context, int index) => SizedBox(width: 5.w),
                  //     itemCount: 3,
                  //     itemBuilder: (context, index) {
                  //       return Container(
                  //         alignment: Alignment.center,
                  //         child: CircleAvatarWidget(
                  //           size: index == 0 ? 26 : 20,
                  //           source: task.leader.avatar,
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
