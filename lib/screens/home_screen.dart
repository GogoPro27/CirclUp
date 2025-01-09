import 'package:circl_up_app/screens/match_page.dart';
import 'package:circl_up_app/services/filter_service.dart';
import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/event.dart';
import '../widgets/marker_button.dart';
import '../widgets/filter_button.dart';
import '../utils/map_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final Map<String, bool> mockFilters = {
    'All': true,
    'event center': true,
    'bar': true,
    'cafe': true,
  };

  bool _showRedDot = false; // Tracks the visibility of the red dot
  bool _showFastForwardButton = true; // Tracks the visibility of the "Fast Forward" button
  late AnimationController _animationController;

  List<Event> get filteredEvents =>
      FilterService.applyFilters(mockEvents, mockFilters);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // 1-second blinking interval
    )..repeat(reverse: true); // Makes the animation oscillate
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildBlinkingDot() {
    return FadeTransition(
      opacity: _animationController,
      child: Container(
        width: 20,
        height: 20,
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: mockFilters.keys.map((String type) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(type),
                      Checkbox(
                        value: mockFilters[type],
                        onChanged: (bool? value) {
                          setDialogState(() {
                            if (type == 'All') {
                              mockFilters.forEach((key, _) {
                                mockFilters[key] = value ?? false;
                              });
                            } else {
                              mockFilters[type] = value ?? false;
                              mockFilters['All'] =
                                  mockFilters.values.every((v) => v);
                            }
                          });
                          setState(() {});
                        },
                      ),
                    ],
                  );
                }).toList(),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showFastForwardDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "If you click continue, you will fast forward to the time of the event's start",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        _showFastForwardButton = false; // Remove the button
                        _showRedDot = true; // Show the blinking red dot

                        // Mark the event with "stanica.jpeg" as participating
                        for (var event in mockEvents) {
                          if (event.place.logo == 'assets/stanica.jpeg') {
                            event.isParticipating = true;
                            event.attendees++; // Increment attendees
                            break;
                          }
                        }
                      });
                    },
                    child: const Text("Continue"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("X", style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            InteractiveViewer(
              transformationController: mapController.transformationController,
              constrained: false,
              boundaryMargin: EdgeInsets.zero,
              minScale: 0.4,
              maxScale: 0.4,
              scaleEnabled: false,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/skopje_map.jpg',
                    width: 8192,
                    height: 3993,
                    fit: BoxFit.cover,
                  ),
                  for (var event in filteredEvents)
                    Positioned(
                      left: event.place.x,
                      top: event.place.y,
                      child: MarkerButton(
                        event: event,
                        onParticipationChanged: () {
                          setState(() {});
                        },
                      ),
                    ),
                ],
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: GestureDetector(
                onTap: _showRedDot
                    ? () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const MatchPage()),
                        );
                      }
                    : null, // Only allow navigation when red dot is visible
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/Cupp_pair.png',
                      width: 80,
                      height: 80,
                    ),
                    if (_showRedDot)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: _buildBlinkingDot(),
                      ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: FilterButton(
                onPressed: () {
                  _showFilterDialog(context);
                },
              ),
            ),
            if (_showFastForwardButton)
              Positioned(
                top: 70, // Adjusted to appear below the filter button
                right: 10,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: _showFastForwardDialog,
                  child: const Text(
                    "Fast Forward",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              
          ],
        ),
      ),
    );
  }
}