import 'package:flutter/material.dart';
import '../models/event.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TransformationController _controller;
  late double _scale;

  // Event list
  final List<Event> allEvents = [
    Event(
        name: 'Stanica 26',
        description: 'A vibrant event center.',
        type: 'event center',
        attendees: 150,
        x: 3500,
        y: 1100,
        imagePath: 'assets/stanica.jpeg'),
    Event(
        name: 'Kotur',
        description: 'A cozy bar.',
        type: 'bar',
        attendees: 75,
        x: 3185,
        y: 1683,
        imagePath: 'assets/kotur.png'),
    Event(
        name: 'Papillon',
        description: 'A trendy cafe.',
        type: 'cafe',
        attendees: 40,
        x: 3588,
        y: 2011,
        imagePath: 'assets/papillon.png'),
  ];

  // Filtering logic
  final Map<String, bool> eventTypes = {
    'All': true,
    'event center': true,
    'bar': true,
    'cafe': true,
  };

  @override
  void initState() {
    super.initState();
    _scale = 0.4; // Initial zoom level
    _controller = TransformationController();
    _controller.value = Matrix4.identity()..scale(_scale);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Event> get filteredEvents {
    if (eventTypes['All'] == true) {
      return allEvents;
    }
    return allEvents.where((event) => eventTypes[event.type] == true).toList();
  }

  void updateFilters(String type, bool isSelected) {
    setState(() {
      if (type == 'All') {
        eventTypes.forEach((key, _) {
          eventTypes[key] = isSelected;
        });
      } else {
        eventTypes[type] = isSelected;
        eventTypes['All'] = eventTypes.values.every((value) => value == true);
      }
    });
  }

  void showFilterDialog(BuildContext context) {
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
                children: eventTypes.keys.map((String type) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(type),
                      Checkbox(
                        value: eventTypes[type],
                        onChanged: (bool? value) {
                          setDialogState(() {
                            if (type == 'All') {
                              eventTypes.forEach((key, _) {
                                eventTypes[key] = value ?? false;
                              });
                            } else {
                              eventTypes[type] = value ?? false;
                              eventTypes['All'] =
                                  eventTypes.values.every((v) => v);
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
        bottom: false, // Prevent SafeArea from adding padding at the bottom
        child: Stack(
          children: [
            // Map and markers
            ClipRect(
              child: InteractiveViewer(
                transformationController: _controller,
                constrained: false,
                boundaryMargin: EdgeInsets.zero,
                minScale: _scale,
                maxScale: _scale,
                scaleEnabled: false, // Disable manual zooming
                child: Stack(
                  children: [
                    // The map image
                    SizedBox(
                      width: 8192, // Full map width
                      height: 3993, // Full map height
                      child: Image.asset(
                        'assets/skopje_map.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Dynamic markers
                    for (var event in filteredEvents)
                      Positioned(
                        left: event.x,
                        top: event.y,
                        child: MarkerButton(imagePath: event.imagePath),
                      ),
                  ],
                ),
              ),
            ),
            // Top filter button
            Positioned(
              top: 10, // Adjusted position within SafeArea
              left: 300,
              right: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      backgroundColor: Colors.black, // Matches the button style
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      showFilterDialog(context);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          "Filter",
                          style: TextStyle(color: Colors.white), // White text
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white, // White icon color
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Navigation bar
            Align(
              alignment: Alignment.bottomCenter,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.orange,
                unselectedItemColor: Colors.grey,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.map), // Map icon
                    label: 'Map',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.card_giftcard), // Rewards icon
                    label: 'Rewards',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.notifications), // Notifications icon
                    label: 'Notifications',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person), // Profile icon
                    label: 'Profile',
                  ),
                ],
                onTap: (index) {
                  // Navigation logic
                  switch (index) {
                    case 0:
                      // Stay on the map screen
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
            ),
          ],
        ),
      ),
    );
  }
}

class MarkerButton extends StatelessWidget {
  final String imagePath;

  const MarkerButton({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Marker tapped!');
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 100,
            height: 130,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Positioned(
            top: 8,
            child: ClipOval(
              child: Image.asset(
                imagePath,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}