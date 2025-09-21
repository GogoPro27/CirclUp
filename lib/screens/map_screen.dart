import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:circl_up_app/screens/match_page.dart'; // 👈 import MatchPage
import '../data/data.dart'; // where your mockEvents live
import '../models/event.dart';
import '../widgets/event_details_bottom_sheet.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  final Set<Marker> _markers = {};
  Event? _selectedEvent; // tapped event

  static const LatLng _skopjeCenter = LatLng(41.9981, 21.4254);

  @override
  void initState() {
    super.initState();
    _loadEventMarkers();
  }

  void _loadEventMarkers() {
    final List<Event> events = mockEvents;

    final newMarkers = events.map((event) {
      return Marker(
        markerId: MarkerId(event.place.name),
        position: LatLng(event.place.x, event.place.y),
        infoWindow: const InfoWindow(),
        consumeTapEvents: true,
        onTap: () {
          setState(() {
            _selectedEvent = event;
          });
        },
      );
    }).toSet();

    setState(() {
      _markers
        ..clear()
        ..addAll(newMarkers);
    });
  }

  void _closeCard() {
    setState(() {
      _selectedEvent = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: _skopjeCenter,
              zoom: 13,
            ),
            markers: _markers,
            onMapCreated: (controller) => _controller = controller,
            onTap: (_) => _closeCard(),
          ),

          // ✅ Top-left Cupp icon
          Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const MatchPage()),
                );
              },
              child: Image.asset(
                'assets/Cupp_pair.png',
                width: 70,
                height: 70,
              ),
            ),
          ),

          // Animated slide-up card (EventDetailsBottomSheet)
          AnimatedSlide(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            offset: _selectedEvent == null ? const Offset(0, 1) : Offset.zero,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _selectedEvent == null ? 0 : 1,
              child: _selectedEvent == null
                  ? const SizedBox.shrink()
                  : Align(
                alignment: Alignment.bottomCenter,
                child: EventDetailsBottomSheet(
                  event: _selectedEvent!,
                  onParticipationChanged: () {
                    setState(() {}); // refresh participants count
                  },
                  onClose: _closeCard,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
