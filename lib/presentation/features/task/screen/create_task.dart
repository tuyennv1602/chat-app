import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/injector/injector.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/utils/validator.dart';
import 'package:chat_app/common/widgets/app_bar.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:chat_app/common/widgets/button_widget.dart';
import 'package:chat_app/common/widgets/input_widget.dart';
import 'package:chat_app/domain/entities/member_entity.dart';
import 'package:chat_app/domain/entities/room_entity.dart';
import 'package:chat_app/domain/entities/task_entity.dart';
import 'package:chat_app/presentation/features/task/bloc/create_task_bloc/create_task_bloc.dart';
import 'package:chat_app/presentation/features/task/widgets/custom_prioriry_dropdown.dart';
import 'package:chat_app/presentation/features/task/widgets/list_member_create_task.dart';
import 'package:chat_app/presentation/features/task/widgets/task_time_widget.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';

class CreateTaskScreen extends StatefulWidget {
  static const String router = '/create_task';
  final RoomEntity room;
  final TaskEntity task;

  CreateTaskScreen({Key key, this.room, this.task}) : super(key: key);

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  TextEditingController _taskTitleCtrl;
  TextEditingController _taskContentCtrl;
  List<int> _listSelectedMemberId;
  DateTime _createDate;
  DateTime _finishDate;
  int _priorityId;

  final _listMem = [
    MemberEntity(id: 1, fullname: 'Lê Văn Luyện', nickname: 'luyen_nguyen'),
    MemberEntity(id: 2, fullname: 'Lê Văn Luyện', nickname: 'luyen_nguyen'),
    MemberEntity(id: 3, fullname: 'Lê Văn Luyện', nickname: 'luyen_nguyen'),
    MemberEntity(id: 4, fullname: 'Lê Văn Luyện', nickname: 'luyen_nguyen'),
    MemberEntity(id: 5, fullname: 'Lê Văn Luyện', nickname: 'luyen_nguyen'),
    MemberEntity(id: 6, fullname: 'Lê Văn Luyện', nickname: 'luyen_nguyen'),
  ];

  CreateTaskBloc _createTaskBloc;

  @override
  void initState() {
    _createDate = DateTime.now();
    _finishDate = _createDate.add(const Duration(minutes: 15));
    _listSelectedMemberId = [];

    _taskTitleCtrl = TextEditingController()..addListener(() {
      _createTaskBloc.add(OnValidateCreateTaskEvent(taskTitle: _taskTitleCtrl.text));
    });
    _taskContentCtrl = TextEditingController()..addListener(() {
      _createTaskBloc.add(OnValidateCreateTaskEvent(taskContent: _taskContentCtrl.text));
    });
    _createTaskBloc = Injector.resolve<CreateTaskBloc>()
      ..add(
        OnValidateCreateTaskEvent(
          createDate: _createDate,
          finishDate: _finishDate,
          listSelectedMemberId: _listSelectedMemberId,
          taskTitle: '_taskTitleCtrl.text',
          taskContent: ' _taskContentCtrl.text',
          priorityId: _priorityId,
        ),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarWidget(
            onTapLeading: () => Routes.instance.pop(),
            center: Text(
              translate(StringConst.createTask),
              style: textStyleAppbar,
            ),
          ),
          SizedBox(height: 15.w),
          CustomPriorityDropDownList(
            createTaskBloc: _createTaskBloc,
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.w, right: 15.w, left: 15.w),
            child: Column(
              children: [
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: InputWidget(
                    placeHolder: translate(StringConst.task),
                    controller: _taskTitleCtrl,
                    validator: Validator.validTaskTitle,
                  ),
                ),
                SizedBox(height: 15.w),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: InputWidget(
                    placeHolder: translate(StringConst.contentTask),
                    controller: _taskContentCtrl,
                    validator: Validator.validTaskContent,
                    textAlignVertical: TextAlignVertical.top,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  translate(StringConst.time),
                  style: textStyleInput.copyWith(
                    color: AppColors.warmGrey,
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 10.w),
                TaskTimeWidget(
                  startTime: _createDate,
                  finishTime: _finishDate,
                  createTaskBloc: _createTaskBloc,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListMemberCreateTask(
              listAllMember: _listMem,
              listSelectedMemberId: _listSelectedMemberId,
              createTaskBloc: _createTaskBloc,
            ),
          ),
          BlocBuilder(
            cubit: _createTaskBloc,
            builder: (context, state) {
              return ButtonWidget(
                label: translate(StringConst.createTask),
                margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                isEnable: state.enableButton,
                onTap: () {
                  if (state.enableButton) {
                    debugPrint('Hung DQ: On submit create task!');
                  }
                },
              );
            },
          )
        ],
      ),
    );
  }
}
