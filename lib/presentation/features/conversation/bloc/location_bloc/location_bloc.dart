import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/exception/network_exception.dart';
import 'package:chat_app/data/models/position_model.dart';
import 'package:chat_app/domain/usecases/room_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/global.dart';
import 'package:chat_app/common/extensions/dio_ext.dart';
import 'package:geocoder/geocoder.dart';

import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final RoomUseCase roomUseCase;

  LocationBloc({
    this.roomUseCase,
  }) : super(InitialLocationState());

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async* {
    switch (event.runtimeType) {
      case UpdateLocationEvent:
        yield* _mapUpdateLocationEvent(event);
        break;
      default:
    }
  }

  Stream<LocationState> _mapUpdateLocationEvent(UpdateLocationEvent event) async* {
    try {
      yield UpdatingLocationState();
      String description;
      final addresses = await Geocoder.local.findAddressesFromCoordinates(
          Coordinates(event.location.latitude, event.location.longitude));
      if (addresses != null && addresses.isNotEmpty) {
        description = addresses.first.addressLine;
      }
      await roomUseCase.updateLocation(
        PositionModel(
          lat: event.location.latitude,
          lng: event.location.longitude,
          description: description,
        ),
        event.userId,
        event.roomId,
      );
      yield UpdatedLocationState(event.location);
    } on DioError catch (e) {
      yield ErroredUpdateLocationState(e.errorMessage);
    } on NetworkException catch (e) {
      yield ErroredUpdateLocationState(e.message);
    } catch (e) {
      yield ErroredUpdateLocationState(translate(StringConst.unknowError));
    }
  }
}
