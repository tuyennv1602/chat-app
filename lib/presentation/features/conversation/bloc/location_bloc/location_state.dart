import 'package:equatable/equatable.dart';
import 'package:location/location.dart';

abstract class LocationState extends Equatable {}

class InitialLocationState extends LocationState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class UpdatingLocationState extends LocationState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class UpdatedLocationState extends LocationState {
  final LocationData location;

  UpdatedLocationState(this.location);

  @override
  List<Object> get props => [location];
}

class ErroredUpdateLocationState extends LocationState {
  final String error;

  ErroredUpdateLocationState(this.error);

  @override
  List<Object> get props => [error];
}
