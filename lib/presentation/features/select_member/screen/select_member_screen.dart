import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/injector/injector.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/widgets/app_bar.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:chat_app/common/widgets/button_widget.dart';
import 'package:chat_app/common/widgets/item_member.dart';
import 'package:chat_app/common/widgets/search_box.dart';
import 'package:chat_app/common/widgets/status_widget.dart';
import 'package:chat_app/presentation/features/select_member/bloc/search_member_bloc/search_member_bloc.dart';
import 'package:chat_app/presentation/features/select_member/bloc/search_member_bloc/search_member_event.dart';
import 'package:chat_app/presentation/features/select_member/bloc/search_member_bloc/search_member_state.dart';
import 'package:chat_app/presentation/features/select_member/bloc/select_member_bloc/select_member_bloc.dart';
import 'package:chat_app/presentation/features/select_member/bloc/select_member_bloc/select_member_event.dart';
import 'package:chat_app/presentation/features/select_member/bloc/select_member_bloc/select_member_state.dart';
import 'package:chat_app/presentation/features/select_member/widget/item_selected_member.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';

class SelectMemberScreen extends StatefulWidget {
  static const String route = '/select-member';
  final SelectMemberBloc selectMemberBloc;

  SelectMemberScreen({
    Key key,
    this.selectMemberBloc,
  }) : super(key: key);

  @override
  _SelectMemberScreenState createState() => _SelectMemberScreenState();
}

class _SelectMemberScreenState extends State<SelectMemberScreen> {
  SearchMemberBloc _searchMemberBloc;

  @override
  void initState() {
    _searchMemberBloc = Injector.resolve<SearchMemberBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _searchMemberBloc),
        BlocProvider.value(value: widget.selectMemberBloc)
      ],
      child: BaseScaffold(
        child: SafeArea(
          top: false,
          child: BlocBuilder<SelectMemberBloc, SelectMemberState>(
            builder: (context, selectedState) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarWidget(
                  center: Container(
                    child: BlocBuilder<SearchMemberBloc, SearchMemberState>(
                      builder: (context, state) => SearchBoxWidget(
                        hintText: translate(StringConst.inputMemberName),
                        isLoading: state is SearchingMemberState,
                        onKeyChanged: (value) {
                          if (value.isNotEmpty) {
                            _searchMemberBloc.add(RequestSearchMemberEvent(value));
                          } else {
                            _searchMemberBloc.add(ClearSearchMemberEvent());
                          }
                        },
                      ),
                    ),
                  ),
                  onTapLeading: () => Navigator.of(context).pop(),
                ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.w, top: 10.w),
                    child: Row(
                      children: selectedState.members
                          .map((member) => ItemSelectedMember(
                                member: member,
                                onDelete: () {
                                  widget.selectMemberBloc.add(
                                    RemoveMemberEvent(
                                      selectedState.members.indexOf(member),
                                    ),
                                  );
                                },
                              ))
                          .toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
                  child: Text(
                    translate(StringConst.resultSearch),
                    style: textStyleMedium.copyWith(
                      color: Colors.grey,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<SearchMemberBloc, SearchMemberState>(
                    builder: (context, searchState) {
                      if (searchState is SearchMemberSuccessState) {
                        if (searchState.members.isEmpty) {
                          return StatusWidget.empty(message: '');
                        }
                        return ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          itemBuilder: (_, index) {
                            final _member = searchState.members[index];
                            final _selectedIndex = selectedState.members.indexOf(_member);
                            return ItemMember(
                              member: _member,
                              memberAction: MemberAction.select,
                              isSelected: _selectedIndex != -1,
                              onTap: (member) {
                                if (_selectedIndex != -1) {
                                  widget.selectMemberBloc.add(RemoveMemberEvent(_selectedIndex));
                                } else {
                                  widget.selectMemberBloc.add(AddMemberEvent(member));
                                }
                              },
                            );
                          },
                          separatorBuilder: (_, index) => SizedBox(height: 10.h),
                          itemCount: searchState.members.length,
                        );
                      }
                      if (searchState is ErroredSearchMemberState) {
                        return StatusWidget.error(message: searchState.error);
                      }
                      return const SizedBox();
                    },
                  ),
                ),
                ButtonWidget(
                  label: '${translate(StringConst.selected)} ${selectedState.members.length}',
                  margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
