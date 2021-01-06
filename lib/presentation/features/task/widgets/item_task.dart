import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/widgets/circle_avatar.dart';
import 'package:chat_app/domain/entities/task_entity.dart';
import 'package:chat_app/presentation/features/task/screen/task_detail.dart';
import 'package:chat_app/presentation/features/task/screen/task_option.dart';
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
  final bool isAdmin;
  int size = 20;

  ItemTask({Key key, this.task, this.isAdmin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Routes.instance.navigate(TaskDetailScreen.route, arguments: {
        'taskId': task.id,
        'taskTitle': task.name,
        'isAdmin': isAdmin,
      }),
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          task.content ?? '',
                          style: textStyleLabel,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return TaskOptionSheet(task: task, isAdmin: isAdmin);
                          },
                          isScrollControlled: true,
                        ),
                        child: Container(
                          padding: const EdgeInsets.only(left: 15, bottom: 10, top: 5),
                          child: SvgPicture.asset(
                            IconConst.ellipsis,
                            width: 10,
                            height: 12,
                            color: AppColors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      SvgPicture.asset(
                        IconConst.calendar,
                        width: 13,
                        height: 13,
                        color: AppColors.black,
                      ),
                      const SizedBox(width: 17),
                      Text(
                        '${task.startTime.toFormat('HH:mm dd/MM/yy') ?? ''} - ${task.endTime.toFormat('HH:mm dd/MM/yy') ?? ''}',
                        style: textStyleRegular,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: CircleAvatarWidget(
                                size: 20,
                                source: task.leader.avatar,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '${translate(StringConst.boss)}: ${task.leader.fullname ?? ''}',
                              style: textStyleRegular,
                            ),
                          ],
                        ),
                      ),
                      SvgPicture.asset(
                        IconConst.flag,
                        width: 18,
                        height: 18,
                        color: task.taskPriority,
                      ),
                    ],
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
