import 'package:chat_app/domain/entities/position_entity.dart';

class PositionModel extends PositionEntity {
  PositionModel({
    double lat,
    double lng,
    String description,
  }) : super(
          lat: lat,
          lng: lng,
          description: description,
        );

  PositionModel.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['long'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lat'] = lat;
    data['long'] = lng;
    data['description'] = description;
    return data;
  }
}
