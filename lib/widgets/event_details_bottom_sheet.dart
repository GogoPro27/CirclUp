import 'package:flutter/material.dart';
import '../models/event.dart';

class EventDetailsBottomSheet extends StatefulWidget {
  final Event event;
  final VoidCallback onParticipationChanged; // Callback to notify changes

  const EventDetailsBottomSheet({
    Key? key,
    required this.event,
    required this.onParticipationChanged,
  }) : super(key: key);

  @override
  State<EventDetailsBottomSheet> createState() => _EventDetailsBottomSheetState();
}

class _EventDetailsBottomSheetState extends State<EventDetailsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              widget.event.photoUrl,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.event.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            '07.01.2024\n23:00 - 02:00',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            widget.event.description,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (widget.event.isParticipating) {
                  widget.event.attendees--;
                } else {
                  widget.event.attendees++;
                }
                widget.event.isParticipating = !widget.event.isParticipating;

                // Notify the parent widget about the change
                widget.onParticipationChanged();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.event.isParticipating
                  ? Colors.white
                  : Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(
                  color: Colors.orange,
                  width: widget.event.isParticipating ? 2 : 0,
                ),
              ),
            ),
            child: Text(
              widget.event.isParticipating ? "CANCEL" : "PARTICIPATE",
              style: TextStyle(
                color: widget.event.isParticipating ? Colors.orange : Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${widget.event.attendees} participants till now',
            style: const TextStyle(color: Colors.orange),
          ),
        ],
      ),
    );
  }
}