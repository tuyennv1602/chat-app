import 'package:chat_app/data/models/message_model.dart';

class MessagesResponseModel {
  bool hasNext;
  bool hasPrev;
  List<MessageModel> items;
  int nextNum;
  int page;
  int pages;
  int perPage;
  int prevNum;
  int total;

  MessagesResponseModel({
    this.hasNext,
    this.hasPrev,
    this.items,
    this.nextNum,
    this.page,
    this.pages,
    this.perPage,
    this.prevNum,
    this.total,
  });

  MessagesResponseModel.fromJson(Map<String, dynamic> json) {
    hasNext = json['has_next'];
    hasPrev = json['has_prev'];
    if (json['items'] != null) {
      items = <MessageModel>[];
      json['items'].forEach((v) {
        items.add(MessageModel.fromJson(v));
      });
    }
    nextNum = json['next_num'];
    page = json['page'];
    pages = json['pages'];
    perPage = json['per_page'];
    prevNum = json['prev_num'];
    total = json['total'];
  }
}
