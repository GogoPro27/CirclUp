import 'package:flutter/widgets.dart';

class MapController {
  static final MapController _instance = MapController._internal();

  factory MapController() => _instance;

  final TransformationController transformationController =
      TransformationController();

  MapController._internal() {
    _centerMapOnMarkers();
  }

  void _centerMapOnMarkers() {
    // Coordinates for your markers (adjust based on your data)
    final markers = [
      Offset(3500, 1100), // Stanica 26
      Offset(3185, 1683), // Kotur
      Offset(3588, 2011), // Papillon
    ];

    // Find the bounding box of all markers
    final double minX = markers.map((marker) => marker.dx).reduce((a, b) => a < b ? a : b);
    final double maxX = markers.map((marker) => marker.dx).reduce((a, b) => a > b ? a : b);
    final double minY = markers.map((marker) => marker.dy).reduce((a, b) => a < b ? a : b);
    final double maxY = markers.map((marker) => marker.dy).reduce((a, b) => a > b ? a : b);

    // Calculate the center of the bounding box
    final centerX = (minX + maxX) / 2;
    final centerY = (minY + maxY) / 2;

    // Set the initial scale and translation for the map
    final double scale = 0.4; // Adjust this as needed for the desired zoom level
    final Offset centerOffset = Offset(-centerX, -centerY) * scale;

    transformationController.value = Matrix4.identity()
      ..scale(scale)
      ..translate(centerOffset.dx, centerOffset.dy);
  }
}

final mapController = MapController();