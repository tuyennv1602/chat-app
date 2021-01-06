import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/injector/injector.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/utils/alert_utils.dart';
import 'package:chat_app/common/widgets/app_bar.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:chat_app/common/widgets/custom_alert.dart';
import 'package:chat_app/common/widgets/item_member.dart';
import 'package:chat_app/common/widgets/loading_widget.dart';
import 'package:chat_app/domain/entities/task_entity.dart';
import 'package:chat_app/presentation/features/task/bloc/task_detail_bloc/task_detail_bloc.dart';
import 'package:chat_app/presentation/features/task/screen/task_option.dart';
import 'package:chat_app/presentation/features/task/widgets/count_down_widget.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_translate/flutter_translate.dart';

class TaskDetailScreen extends StatefulWidget {
  static const String route = '/task_detail';
  final String taskTitle;
  final int taskId;
  final bool isAdmin;

  TaskDetailScreen({Key key, this.taskTitle, this.taskId, this.isAdmin}) : super(key: key);

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  TaskDetailBloc _taskDetailBloc;
  TaskEntity _task = TaskEntity();

  @override
  void initState() {
    super.initState();
    _taskDetailBloc = Injector.resolve<TaskDetailBloc>()..add(OnGetTaskDetailEvent(taskId: widget.taskId));
  }

  @override
  void dispose() {
    _taskDetailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Column(
        children: [
          AppBarWidget(
            onTapLeading: () => Routes.instance.pop(),
            center: Text(
              widget.taskTitle ?? '',
              style: textStyleAppbar,
              maxLines: 1,
            ),
            trailing: GestureDetector(
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (context) {
                  return TaskOptionSheet(task: _task, isAdmin: widget.isAdmin);
                },
                isScrollControlled: true,
              ),
              child: SvgPicture.asset(
                IconConst.menu,
                width: 20.w,
                height: 20.w,
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<TaskDetailBloc, TaskDetailState>(
              cubit: _taskDetailBloc,
              builder: (context, state) {
                if (state is LoadingTaskDetailState) {
                  return LoadingWidget();
                }
                if (state is ErrorLoadTaskDetailState) {
                  AlertUtil.show(
                    context,
                    child: CustomAlertWidget.error(
                      title: translate(StringConst.notification),
                      message: state.error,
                    ),
                  );
                }
                if (state is LoadedTaskDetailState) {
                  _task = state.task;
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5.w)),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xFFD1D1D1),
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          margin: EdgeInsets.only(top: 10.w),
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                translate(StringConst.finishIn),
                                style: textStyleInput.copyWith(
                                  color: AppColors.greyText,
                                ),
                              ),
                              CountDownTimer(
                                createDate: _task.startTime,
                                finishDate: _task.endTime,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15.w),
                          child: Text(
                            '${translate(StringConst.priority)}: ${_task.priority ?? ''}',
                            style: textStyleInput,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.w),
                          child: Text(
                            '${translate(StringConst.contentTask)}: ${_task.content ?? ''}',
                            style: textStyleInput,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            translate(StringConst.memberImplement),
                            style: textStyleInput.copyWith(color: AppColors.greyText, fontSize: 13.sp),
                          ),
                        ),
                        SizedBox(height: 10.w),
                        Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            itemBuilder: (_, index) {
                              return ItemMember(
                                member: _task.members[index],
                                memberAction: MemberAction.completed,
                              );
                            },
                            separatorBuilder: (_, index) => SizedBox(height: 10.h),
                            itemCount: _task.members.length,
                          ),
                        )
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
