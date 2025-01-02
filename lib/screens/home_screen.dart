import 'package:circl_up_app/services/filter_service.dart';
import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/event.dart';
import '../widgets/marker_button.dart';
import '../widgets/filter_button.dart';
import '../widgets/navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Define mockFilters to manage filter states
  final Map<String, bool> mockFilters = {
    'All': true,
    'event center': true,
    'bar': true,
    'cafe': true,
  };

  late TransformationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TransformationController();
    _controller.value = Matrix4.identity()..scale(0.4);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
 
  // Getter to filter events based on selected filters
  List<Event> get filteredEvents => FilterService.applyFilters(mockEvents, mockFilters);

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
                          setState(() {}); // Update the main UI
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // Map and markers
            InteractiveViewer(
              transformationController: _controller,
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
                      left: event.x,
                      top: event.y,
                      child: MarkerButton(
                        event: event,
                        onParticipationChanged: () {
                          setState(() {}); // Refresh the UI
                        },
                      ),
                    ),
                ],
              ),
            ),
            // Top filter button
            Positioned(
              top: 10,
              left: 300,
              right: 10,
              child: FilterButton(
                onPressed: () {
                  _showFilterDialog(context);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar( 
        onTap: (index) {
          switch (index) {
            case 0:
              // Stay on the home screen
              break;
            case 1:
              Navigator.pushNamed(context, '/rewards');
              break;
            case 2:
              Navigator.pushNamed(context, '/notifications');
              break;
            case 3:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }
}