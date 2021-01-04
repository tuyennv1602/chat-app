import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/widgets/item_member.dart';
import 'package:chat_app/domain/entities/member_entity.dart';
import 'package:chat_app/presentation/features/task/bloc/create_task_bloc/create_task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_translate/global.dart';

class ListMemberCreateTask extends StatefulWidget {
  final List<MemberEntity> listAllMember;
  final List<int> listSelectedMemberId;
  final CreateTaskBloc createTaskBloc;

  ListMemberCreateTask({
    Key key,
    this.listAllMember,
    this.listSelectedMemberId,
    this.createTaskBloc,
  }) : super(key: key);

  @override
  _ListMemberCreateTaskState createState() => _ListMemberCreateTaskState();
}

class _ListMemberCreateTaskState extends State<ListMemberCreateTask> {
  List<int> _listSelectedMember = [];
  bool _isSelectedAll = false;

  @override
  void initState() {
    super.initState();
    _listSelectedMember = widget.listSelectedMemberId ?? [];
  }

  void _onSelectedMember({int id}) {
    if (id != null) {
      _listSelectedMember.contains(id) ? _listSelectedMember.remove(id) : _listSelectedMember.add(id);
    } else {
      _isSelectedAll = !_isSelectedAll;
      if (_isSelectedAll) {
        _listSelectedMember = [];
        widget.listAllMember.forEach((e) {
          _listSelectedMember.add(e.id);
        });
      } else {
        _listSelectedMember = [];
      }
    }
    widget.createTaskBloc.add(OnValidateCreateTaskEvent(listSelectedMemberId: _listSelectedMember));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                translate(StringConst.member),
                style: textStyleMedium.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              GestureDetector(
                onTap: _onSelectedMember,
                child: Text(
                  _isSelectedAll ? translate(StringConst.unChecked) : translate(StringConst.selectAll),
                  style: textStyleMedium.copyWith(
                    color: _isSelectedAll ? AppColors.red : AppColors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5.w),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            itemBuilder: (_, index) {
              return ItemMember(
                onTap: (member) => _onSelectedMember(id: member.id),
                member: widget.listAllMember[index],
                isSelected: _listSelectedMember.contains(widget.listAllMember[index].id),
              );
            },
            separatorBuilder: (_, index) => SizedBox(height: 10.h),
            itemCount: widget.listAllMember.length,
          ),
        ),
      ],
    );
  }
}
