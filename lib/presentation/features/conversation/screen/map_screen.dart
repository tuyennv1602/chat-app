import 'dart:async';

import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/utils/marker_utils.dart';
import 'package:chat_app/common/utils/screen_utils.dart';
import 'package:chat_app/domain/entities/map_marker.dart';
import 'package:chat_app/domain/entities/member_entity.dart';
import 'package:chat_app/presentation/features/conversation/widget/member_information.dart';
import 'package:fluster/fluster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';

class MapScreen extends StatefulWidget {
  static const String route = '/map';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final List<LatLng> _markerLocations = const [
    LatLng(41.147125, -8.611249),
    LatLng(41.145599, -8.610691),
    LatLng(41.145645, -8.614761),
    LatLng(41.146775, -8.614913),
    LatLng(41.146982, -8.615682),
    LatLng(41.140558, -8.611530),
    LatLng(41.138393, -8.608642),
    LatLng(41.137860, -8.609211),
    LatLng(41.138344, -8.611236),
    LatLng(41.139813, -8.609381),
  ];
  final Set<Marker> _markers = {};
  final int _minClusterZoom = 0;
  final int _maxClusterZoom = 20;
  Fluster<MapMarker> _clusterManager;
  double _currentZoom = 15;
  bool _areMarkersLoading = true;
  final String _markerImageUrl = 'https://www.gstatic.com/tv/thumb/persons/983712/983712_v9_ba.jpg';
  final _myLocation = const CameraPosition(
    target: LatLng(41.143029, -8.611274),
    zoom: 15,
  );
  final Completer<GoogleMapController> _mapController = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
    _initMarkers();
  }

  Future<void> _initMarkers() async {
    final markers = <MapMarker>[];
    for (final markerLocation in _markerLocations) {
      final markerImage = await MarkerUtils.getMarkerImageFromUrl(_markerImageUrl);
      markers.add(
        MapMarker(
          id: _markerLocations.indexOf(markerLocation).toString(),
          position: markerLocation,
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
    setState(() {
      _areMarkersLoading = true;
    });
    final updatedMarkers = await MarkerUtils.getClusterMarkers(
      _clusterManager,
      _currentZoom,
      Colors.red,
      Colors.white,
      80,
    );
    _markers
      ..clear()
      ..addAll(updatedMarkers);
    setState(() {
      _areMarkersLoading = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: GoogleMap(
              mapToolbarEnabled: false,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              mapType: MapType.terrain,
              initialCameraPosition: _myLocation,
              markers: _markers,
              onMapCreated: _onMapCreated,
              onCameraMove: (position) => _updateMarkers(position.zoom),
            ),
          ),
          if (_areMarkersLoading)
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil.statusBarHeight + 10),
              child: Align(
                alignment: Alignment.topCenter,
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
              ),
            ),
          Positioned(
            top: ScreenUtil.statusBarHeight + 10,
            left: 10,
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
                    width: 15.w,
                    height: 15.w,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: ScreenUtil.statusBarHeight + 10,
            right: 10,
            child: GestureDetector(
              onTap: () => _animateToPosition(_myLocation.target),
              child: Container(
                width: 45.w,
                height: 45.w,
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
                    IconConst.focus,
                    width: 22.w,
                    height: 22.w,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
