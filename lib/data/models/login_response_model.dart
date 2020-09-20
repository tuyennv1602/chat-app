import 'package:chat_app/data/models/user_model.dart';

class LoginResponseModel {
  String token;
  UserModel userModel;

  LoginResponseModel({this.token, this.userModel});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userModel = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = token;
    if (userModel != null) {
      data['user'] = userModel.toJson();
    }
    return data;
  }
}
