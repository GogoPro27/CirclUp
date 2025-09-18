import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../data/mock_data.dart'; // 👈 where your Event/Place lists live
import '../models/event.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  final Set<Marker> _markers = {};

  static const LatLng _skopjeCenter = LatLng(41.9981, 21.4254);

  @override
  void initState() {
    super.initState();
    _loadEventMarkers();
  }

  void _loadEventMarkers() {
    final List<Event> events = mockEvents; // 👈 replace with your list of events

    final newMarkers = events.map((event) {
      return Marker(
        markerId: MarkerId(event.place.name),
        position: LatLng(event.place.x, event.place.y),
        infoWindow: InfoWindow(
          title: event.place.name,
          snippet: event.description,
        ),
      );
    }).toSet();

    setState(() {
      _markers.clear();
      _markers.addAll(newMarkers);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: _skopjeCenter,
          zoom: 13,
        ),
        markers: _markers,
        onMapCreated: (controller) => _controller = controller,
      ),
    );
  }
}
