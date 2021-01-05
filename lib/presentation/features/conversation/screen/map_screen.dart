import 'dart:async';

import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/injector/injector.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/utils/alert_utils.dart';
import 'package:chat_app/common/utils/marker_utils.dart';
import 'package:chat_app/common/utils/screen_utils.dart';
import 'package:chat_app/common/widgets/custom_alert.dart';
import 'package:chat_app/domain/entities/map_marker.dart';
import 'package:chat_app/domain/entities/member_entity.dart';
import 'package:chat_app/domain/entities/member_position_entity.dart';
import 'package:chat_app/presentation/features/conversation/bloc/location_bloc/location_bloc.dart';
import 'package:chat_app/presentation/features/conversation/bloc/location_bloc/location_event.dart';
import 'package:chat_app/presentation/features/conversation/bloc/location_bloc/location_state.dart';
import 'package:chat_app/presentation/features/conversation/bloc/member_position_bloc/member_position_bloc.dart';
import 'package:chat_app/presentation/features/conversation/bloc/member_position_bloc/member_position_event.dart';
import 'package:chat_app/presentation/features/conversation/bloc/member_position_bloc/member_position_state.dart';
import 'package:chat_app/presentation/features/conversation/widget/member_information.dart';
import 'package:fluster/fluster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';

class MapScreen extends StatefulWidget {
  static const String route = '/map';
  final LocationBloc locationBloc;
  final int roomId;

  MapScreen({
    Key key,
    this.locationBloc,
    this.roomId,
  }) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Set<Marker> _markers = {};
  final int _minClusterZoom = 0;
  final int _maxClusterZoom = 20;
  Fluster<MapMarker> _clusterManager;
  double _currentZoom = 15;
  CameraPosition _myLocation = const CameraPosition(target: LatLng(0.0, 0.0));
  final Completer<GoogleMapController> _mapController = Completer();
  // ignore: close_sinks
  LocationBloc _locationBloc;
  MemberPositionBloc _memberPositionBloc;

  @override
  void initState() {
    _memberPositionBloc = Injector.resolve<MemberPositionBloc>();
    _locationBloc = widget.locationBloc;
    final _state = _locationBloc.state;
    if (_state is UpdatedLocationState) {
      _toMyLocation(LatLng(_state.location.latitude, _state.location.longitude));
    }
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
    _memberPositionBloc.add(LoadMemberPositionEvent(widget.roomId));
  }

  void _toMyLocation(LatLng latLng) {
    _myLocation = CameraPosition(target: latLng);
    _animateToPosition(latLng);
  }

  Future<void> _initMarkers(List<MemberPositionEntity> members) async {
    final markers = <MapMarker>[];
    for (final member in members) {
      if (member.position == null) {
        continue;
      }
      final markerImage = await MarkerUtils.getMarkerImageFromUrl(member.user?.fullAvatar);
      markers.add(
        MapMarker(
          id: member.user.id.toString(),
          position: LatLng(member.position.lat, member.position.lng),
          icon: markerImage,
          onTap: () => _openMemberDetail(context),
        ),
      );
    }
    _clusterManager = await MarkerUtils.initClusterManager(
      markers,
      _minClusterZoom,
      _maxClusterZoom,
    );
    await _updateMarkers();
  }

  Future<void> _updateMarkers([double updatedZoom]) async {
    if (_clusterManager == null || updatedZoom == _currentZoom) {
      return;
    }
    if (updatedZoom != null) {
      _currentZoom = updatedZoom;
    }
    final updatedMarkers = await MarkerUtils.getClusterMarkers(
      _clusterManager,
      _currentZoom,
      Colors.red,
      Colors.white,
      60,
    );
    setState(() {
      _markers
        ..clear()
        ..addAll(updatedMarkers);
    });
  }

  Future<void> _animateToPosition(LatLng target) async {
    final controller = await _mapController.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom: _currentZoom),
      ),
    );
  }

  void _openMemberDetail(context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) => MemberInformation(
        memberEntity: MemberEntity(
          code: '100',
          fullname: 'Nguyen Khac Tu',
          nickname: 'nguyen_tu',
        ),
        onShare: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget _secondButton(String icon, Function onPressed) => GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 40.w,
          height: 40.w,
          decoration: const BoxDecoration(
            color: AppColors.grey,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: SvgPicture.asset(
              icon,
              width: 22.w,
              height: 22.w,
              color: Colors.black,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationBloc>.value(value: _locationBloc),
        BlocProvider<MemberPositionBloc>.value(value: _memberPositionBloc),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<LocationBloc, LocationState>(listener: (_, state) {
            if (state is UpdatedLocationState) {
              _toMyLocation(LatLng(state.location.latitude, state.location.longitude));
            }
          }),
          BlocListener<MemberPositionBloc, MemberPositionState>(listener: (_, state) {
            if (state is LoadedMemberPositionState) {
              _initMarkers(state.positions);
            }
            if (state is ErroredMemberPositionState) {
              AlertUtil.show(
                context,
                child: CustomAlertWidget.error(
                  title: translate(StringConst.notification),
                  message: state.error,
                ),
              );
            }
          })
        ],
        child: Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: GoogleMap(
                  mapToolbarEnabled: false,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  myLocationEnabled: false,
                  mapType: MapType.terrain,
                  initialCameraPosition: _myLocation,
                  markers: _markers,
                  onMapCreated: _onMapCreated,
                  onCameraMove: (position) => _updateMarkers(position.zoom),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: BlocBuilder<MemberPositionBloc, MemberPositionState>(builder: (_, state) {
                  if (state is LoadingMemberPositionState) {
                    return Padding(
                      padding: EdgeInsets.only(top: ScreenUtil.statusBarHeight + 10),
                      child: Card(
                        elevation: 2,
                        color: Colors.grey.withOpacity(0.9),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            translate(StringConst.loading),
                            style: textStyleRegular.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                }),
              ),
              Positioned(
                top: ScreenUtil.statusBarHeight + 15,
                left: 15,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        IconConst.back,
                        width: 18.w,
                        height: 18.w,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: ScreenUtil.statusBarHeight + 15,
                right: 15,
                child: Column(
                  children: [
                    _secondButton(
                      IconConst.focus,
                      () => _animateToPosition(_myLocation.target),
                    ),
                    const SizedBox(height: 18),
                    _secondButton(
                      IconConst.refresh,
                      () => _memberPositionBloc.add(
                        LoadMemberPositionEvent(widget.roomId),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
