import 'package:chat_app/data/models/member_model.dart';

class SearchUserResponseModel {
  List<MemberModel> data;

  SearchUserResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MemberModel>[];
      json['data'].forEach((v) {
        data.add(MemberModel.fromJson(v));
      });
    }
  }
}
