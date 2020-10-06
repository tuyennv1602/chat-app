import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/widgets/app_bar.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:chat_app/common/widgets/button_widget.dart';
import 'package:chat_app/common/widgets/circle_button.dart';
import 'package:chat_app/common/widgets/input_widget.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_translate/flutter_translate.dart';

class TaskReportScreen extends StatefulWidget {
  static const String route = '/task_report';
  @override
  _TaskReportScreenState createState() => _TaskReportScreenState();
}

class _TaskReportScreenState extends State<TaskReportScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Column(
        children: [
          AppBarWidget(
            onTapLeading: () => Routes.instance.pop(),
            center: Text(
              'Báo cáo nhiệm vụ',
              style: textStyleAppbar,
            ),
          ),
          Form(
            child: Padding(
              padding: EdgeInsets.all(15.w),
              child: InputWidget(
                placeHolder: 'Nội dung báo cáo',
                maxLines: 4,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
              children: [
                Text(
                  translate(StringConst.attachment),
                  style: textStyleMedium.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    FilePickerResult result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],
                    );
                    if (result != null) {
                      PlatformFile file = result.files.first;

                      debugPrint(file.name);
                      debugPrint(file.bytes.toString());
                      debugPrint(file.size.toString());
                      debugPrint(file.extension);
                      debugPrint(file.path);
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 5.h,
                    ),
                    child: CircleButtonWidget(
                      size: 16.h,
                      isEnable: true,
                      padding: EdgeInsets.all(3.w),
                      urlIcon: IconConst.add,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 5.w),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              itemBuilder: (_, index) =>
                  Text('${index + 1}.IMG_00${index + 1}.jpg'),
              separatorBuilder: (_, index) => SizedBox(
                height: 10.h,
              ),
              itemCount: 4,
            ),
          ),
          ButtonWidget(
            label: 'Gửi báo cáo',
            margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
