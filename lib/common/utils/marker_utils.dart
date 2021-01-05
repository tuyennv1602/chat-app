import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;

import 'package:chat_app/domain/entities/map_marker.dart';
import 'package:fluster/fluster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:chat_app/common/extensions/string_ext.dart';

class MarkerUtils {
  static Future<BitmapDescriptor> getMarkerImageFromUrl(
    String url, {
    int targetWidth = 100,
  }) async {
    Uint8List markerImageBytes;

    if (url.isEmptyOrNull) {
      final byteData = await rootBundle.load('assets/icons/user.svg');
      markerImageBytes =
          byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    } else {
      final markerImageFile = await DefaultCacheManager().getSingleFile(url);
      markerImageBytes = await markerImageFile.readAsBytes();
    }

    markerImageBytes = await _decorImageBytes(
      markerImageBytes,
      targetWidth,
    );
    return BitmapDescriptor.fromBytes(markerImageBytes);
  }

  /// Draw a [clusterColor] circle with the [clusterSize] text inside that is [width] wide.
  ///
  /// Then it will convert the canvas to an image and generate the [BitmapDescriptor]
  /// to be used on the cluster marker icons.
  static Future<BitmapDescriptor> _getClusterMarker(
    int clusterSize,
    Color clusterColor,
    Color textColor,
    int width,
  ) async {
    assert(clusterSize != null, 'clusterSize non null');
    assert(clusterColor != null, 'clusterColor non null');
    assert(width != null, 'width non null');

    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final paint = Paint()..color = clusterColor;
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    final radius = width / 2;
    canvas.drawCircle(
      Offset(radius, radius),
      radius,
      paint,
    );

    textPainter
      ..text = TextSpan(
        text: clusterSize.toString(),
        style: TextStyle(
          fontSize: radius - 4,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      )
      ..layout()
      ..paint(
        canvas,
        Offset(radius - textPainter.width / 2, radius - textPainter.height / 2),
      );

    final image = await pictureRecorder.endRecording().toImage(
          radius.toInt() * 2,
          radius.toInt() * 2,
        );
    final data = await image.toByteData(format: ui.ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }

  static Future<ui.Image> _getImageFromBytes(Uint8List imageBytes) async {
    final completer = Completer<ui.Image>();
    ui.decodeImageFromList(imageBytes, completer.complete);
    return completer.future;
  }

  /// Resizes the given [imageBytes] with the [targetWidth].
  ///
  /// We don't want the marker image to be too big so we might need to resize the image.
  static Future<Uint8List> _decorImageBytes(
    Uint8List imageBytes,
    int targetWidth,
  ) async {
    assert(imageBytes != null, 'imageBytes non null');
    assert(targetWidth != null, 'targetWidth non null');

    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final radius = Radius.circular(targetWidth / 2);
    final tagPaint = Paint()..color = Colors.white;
    const borderWidth = 3.0;
    const imageOffset = borderWidth;

    //draw radius
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0.0, 0.0, targetWidth.toDouble(), targetWidth.toDouble()),
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
        bottomRight: radius,
      ),
      tagPaint,
    );

    // Oval for the image
    final oval = Rect.fromLTWH(
        imageOffset, imageOffset, targetWidth - (imageOffset * 2), targetWidth - (imageOffset * 2));

    // Add path for oval image
    canvas.clipPath(Path()..addOval(oval));

    final image = await _getImageFromBytes(imageBytes);
    // Add image
    paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);

    // Convert canvas to image
    final markerAsImage = await pictureRecorder.endRecording().toImage(targetWidth, targetWidth);

    // Convert image to bytes
    final byteData = await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    return byteData.buffer.asUint8List();
  }

  /// Inits the cluster manager with all the [MapMarker] to be displayed on the map.
  /// Here we're also setting up the cluster marker itself, also with an [clusterImageUrl].
  ///
  /// For more info about customizing your clustering logic check the [Fluster] constructor.
  static Future<Fluster<MapMarker>> initClusterManager(
    List<MapMarker> markers,
    int minZoom,
    int maxZoom,
  ) async {
    assert(markers != null, 'markers non null');
    assert(minZoom != null, 'minZoom non null');
    assert(maxZoom != null, 'maxZoom non null');

    return Fluster<MapMarker>(
      minZoom: minZoom,
      maxZoom: maxZoom,
      radius: 150,
      extent: 2048,
      nodeSize: 64,
      points: markers,
      createCluster: (
        BaseCluster cluster,
        double lng,
        double lat,
      ) =>
          MapMarker(
        id: cluster.id.toString(),
        position: LatLng(lat, lng),
        isCluster: cluster.isCluster,
        clusterId: cluster.id,
        pointsSize: cluster.pointsSize,
        childMarkerId: cluster.childMarkerId,
      ),
    );
  }

  /// Gets a list of markers and clusters that reside within the visible bounding box for
  /// the given [currentZoom]. For more info check [Fluster.clusters].
  static Future<List<Marker>> getClusterMarkers(
    Fluster<MapMarker> clusterManager,
    double currentZoom,
    Color clusterColor,
    Color clusterTextColor,
    int clusterWidth,
  ) {
    assert(currentZoom != null, 'currentZoom non null');
    assert(clusterColor != null, 'clusterColor non null');
    assert(clusterTextColor != null, 'clusterTextColor non null');
    assert(clusterWidth != null, 'clusterWidth non null');

    if (clusterManager == null) {
      return Future.value([]);
    }

    return Future.wait(
        clusterManager.clusters([-180, -85, 180, 85], currentZoom.toInt()).map((mapMarker) async {
      if (mapMarker.isCluster) {
        mapMarker.icon = await _getClusterMarker(
          mapMarker.pointsSize,
          clusterColor,
          clusterTextColor,
          clusterWidth,
        );
      }
      return mapMarker.toMarker();
    }).toList());
  }
}
