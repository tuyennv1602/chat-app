import 'package:equatable/equatable.dart';
import 'package:location/location.dart';

abstract class LocationEvent extends Equatable {}

class UpdateLocationEvent extends LocationEvent {
  final LocationData location;
  final int roomId;
  final int userId;

  UpdateLocationEvent(this.location, this.roomId, this.userId);

  @override
  List<Object> get props => [location];
}
