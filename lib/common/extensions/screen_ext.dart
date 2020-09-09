import 'package:chat_app/common/utils/screen_utils.dart';

extension SizeExt on num {
  num get w => ScreenUtil().setWidth(this);
  num get h => ScreenUtil().setHeight(this);
  num get sp => ScreenUtil().setSp(this);
}
