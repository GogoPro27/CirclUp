import 'package:flutter/material.dart';
import '../models/event.dart';
import '../screens/event_details_screen.dart';

class MarkerButton extends StatelessWidget {
  final Event event;

  const MarkerButton({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsScreen(event: event),
          ),
        );
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
                event.imagePath,
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