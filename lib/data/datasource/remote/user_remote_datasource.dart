import 'package:chat_app/common/network/client.dart';
import 'package:chat_app/data/models/response/search_user_response_model.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UserRemoteDataSource {
  final Client client;
  UserRemoteDataSource({this.client});

  Future<SearchUserResponseModel> searchUser(String key) async {
    final resp = await client.post('user/search/nickname', body: {
      'keyword': key,
    });
    return SearchUserResponseModel.fromJson(resp.data);
  }

  Future<UserModel> getUser() async {
    final resp = await client.get('user/info');
    return UserModel.fromJson(resp.data['data']);
  }

  Future<String> updateAvatar(String filePath, String fileName) async {
    final data = FormData.fromMap(
      {
        'image': await MultipartFile.fromFile(
          filePath,
          filename: '$fileName.jpg',
        ),
      },
    );
    final resp = await client.uploadFile(
      'account/avatar',
      body: data,
    );
    return resp.data['data']['avatar'];
  }
}
