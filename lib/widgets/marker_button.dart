import 'package:flutter/material.dart';
import '../models/event.dart';
import 'event_details_bottom_sheet.dart';

class MarkerButton extends StatelessWidget {
  final Event event;
  final VoidCallback onParticipationChanged;

  const MarkerButton({
    Key? key,
    required this.event,
    required this.onParticipationChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          builder: (context) => FractionallySizedBox(
            heightFactor: 2 / 3,
            widthFactor: 1.0,
            child: EventDetailsBottomSheet(
              event: event,
              onParticipationChanged: onParticipationChanged,
            ),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Pin shape
          CustomPaint(
            size: const Size(100, 140), // Adjust size of the pin
            painter: PinPainter(color: event.isParticipating ? Colors.green : Colors.orange),
          ),
          // Image above the pin
          Positioned(
            top: 50,
            child: ClipOval(
              child: Image.asset(
                event.place.logo,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PinPainter extends CustomPainter {
  final Color color;

  PinPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;

    // Draw the circular top of the pin
    final double circleRadius = size.width / 2;
    canvas.drawCircle(Offset(size.width / 2, circleRadius + 40), circleRadius+10, paint);

    // Draw the triangular bottom of the pin
    final Path trianglePath = Path()
      ..moveTo(size.width / 2, size.height + 40) // Bottom point
      ..lineTo(size.width, circleRadius * 2) // Right base
      ..lineTo(0, circleRadius * 2) // Left base
      ..close();

    canvas.drawPath(trianglePath, paint);
  }

  @override
  bool shouldRepaint(covariant PinPainter oldDelegate) {
    return oldDelegate.color != color; // Repaint if the color changes
  }
}