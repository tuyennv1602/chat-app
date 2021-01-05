import 'package:location/location.dart';

class LocationCheck {
  static Future<Location> initLocation() async {
    final _location = Location();
    var _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }
    var _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    await _location.changeSettings(
      interval: const Duration(minutes: 10).inMilliseconds,
      distanceFilter: 10,
    );
    return _location;
  }
}
