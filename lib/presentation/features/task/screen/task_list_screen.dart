import 'package:chat_app/common/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/injector/injector.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/utils/alert_utils.dart';
import 'package:chat_app/common/widgets/app_bar.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:chat_app/common/widgets/custom_alert.dart';
import 'package:chat_app/common/widgets/loading_widget.dart';
import 'package:chat_app/domain/entities/room_entity.dart';
import 'package:chat_app/domain/entities/task_entity.dart';
import 'package:chat_app/presentation/features/task/bloc/task_list_bloc/task_list_bloc.dart';
import 'package:chat_app/presentation/features/task/screen/create_task.dart';
import 'package:chat_app/presentation/features/task/widgets/item_task.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_translate/flutter_translate.dart';

class TaskListScreen extends StatefulWidget {
  static const String router = '/task_list';

  final RoomEntity room;

  const TaskListScreen({Key key, this.room}) : super(key: key);

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  TaskListBloc _taskListBloc;
  AuthBloc _authBloc;
  List<TaskEntity> _tasks = [];
  bool _isAdmin;

  @override
  void initState() {
    super.initState();
    _taskListBloc = Injector.resolve<TaskListBloc>()..add(OnGetAllTasksEvent(roomId: widget.room.id));
    _authBloc = Injector.resolve<AuthBloc>();
    _isAdmin = _authBloc.state.user.id == widget.room.adminId;
  }

  @override
  void dispose() {
    _taskListBloc.close();
    _authBloc.close();
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
              translate(StringConst.task),
              style: textStyleAppbar,
            ),
            trailing: _isAdmin
                ? GestureDetector(
                    onTap: () async {
                     final result = await Routes.instance.navigate(CreateTaskScreen.router, arguments: {
                       'room': widget.room,
                     });
                     if(result != null && result){
                       _taskListBloc.add(OnGetAllTasksEvent(roomId: widget.room.id));
                     }
                    },
                    child: SvgPicture.asset(
                      IconConst.addTask,
                      width: 20.w,
                      height: 20.w,
                    ),
                  )
                : const SizedBox(),
          ),
          Expanded(
            child: BlocBuilder<TaskListBloc, TaskListState>(
              cubit: _taskListBloc,
              builder: (context, state) {
                if (state is LoadingTasksState) {
                  return LoadingWidget();
                }
                if (state is ErrorLoadTasksState) {
                  AlertUtil.show(
                    context,
                    child: CustomAlertWidget.error(
                      title: translate(StringConst.notification),
                      message: state.error,
                    ),
                  );
                }
                if (state is LoadedTasksState) {
                  _tasks = state.tasks;
                }
                return _tasks.isEmpty
                    ? Center(
                        child: Text(
                          translate(StringConst.noTask),
                          style: textStyleLabel,
                        ),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
                        separatorBuilder: (BuildContext context, int index) => SizedBox(height: 15.w),
                        itemCount: _tasks.length,
                        itemBuilder: (context, index) {
                          return ItemTask(
                            task: _tasks[index],
                          );
                        },
                      );
              },
            ),
          )
        ],
      ),
    );
  }
}
