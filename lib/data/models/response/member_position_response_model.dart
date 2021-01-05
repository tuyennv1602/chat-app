import 'package:chat_app/data/models/member_position_model.dart';

class MemberPositionResponseModel {
  List<MemberPositionModel> data;

  MemberPositionResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MemberPositionModel>[];
      json['data'].forEach((v) {
        data.add(MemberPositionModel.fromJson(v));
      });
    }
  }
}
