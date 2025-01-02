import 'package:flutter/widgets.dart';

class MapController {
  static final MapController _instance = MapController._internal();

  factory MapController() => _instance;

  final TransformationController transformationController =
      TransformationController();

  MapController._internal() {
    // Set the initial scale of the map
    transformationController.value = Matrix4.identity()..scale(0.4);
  }
}

final mapController = MapController();