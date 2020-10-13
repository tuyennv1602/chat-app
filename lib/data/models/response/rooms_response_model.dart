import 'package:chat_app/data/models/room_model.dart';

class RoomResponseModel {
  bool hasNext;
  bool hasPrev;
  List<RoomModel> rooms;
  int nextNum;
  int page;
  int pages;
  int perPage;
  int prevNum;
  int total;

  RoomResponseModel({
    this.hasNext,
    this.hasPrev,
    this.rooms,
    this.nextNum,
    this.page,
    this.pages,
    this.perPage,
    this.prevNum,
    this.total,
  });

  RoomResponseModel.fromJson(Map<String, dynamic> json) {
    hasNext = json['has_next'];
    hasPrev = json['has_prev'];
    if (json['items'] != null) {
      rooms = <RoomModel>[];
      json['items'].forEach((v) {
        rooms.add(RoomModel.fromJson(v));
      });
    }
    nextNum = json['next_num'];
    page = json['page'];
    pages = json['pages'];
    perPage = json['per_page'];
    prevNum = json['prev_num'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['has_next'] = hasNext;
    data['has_prev'] = hasPrev;
    if (rooms != null) {
      data['items'] = rooms.map((v) => v.toJson()).toList();
    }
    data['next_num'] = nextNum;
    data['page'] = page;
    data['pages'] = pages;
    data['per_page'] = perPage;
    data['prev_num'] = prevNum;
    data['total'] = total;
    return data;
  }
}
