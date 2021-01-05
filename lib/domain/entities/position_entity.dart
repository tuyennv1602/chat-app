import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PositionEntity extends Equatable {
  double lat;
  double lng;
  String description;

  PositionEntity({this.lat, this.lng, this.description});

  @override
  List<Object> get props => [lat, lng, description];
}
