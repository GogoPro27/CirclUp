import 'package:flutter/material.dart';
import '../models/event.dart';
import '../data/data.dart';

class EventDetailsBottomSheet extends StatefulWidget {
  final Event event;
  final VoidCallback onParticipationChanged;

  const EventDetailsBottomSheet({
    Key? key,
    required this.event,
    required this.onParticipationChanged,
  }) : super(key: key);

  @override
  State<EventDetailsBottomSheet> createState() =>
      _EventDetailsBottomSheetState();
}

class _EventDetailsBottomSheetState extends State<EventDetailsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    // Check if the place is liked by the user
    bool isLiked = mockUsers[0].favoritePlaces.contains(widget.event.place);

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
          // Event Image
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              widget.event.eventImage,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          // Event Name with Like Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 48), // Spacer for alignment
              Expanded(
                child: Text(
                  widget.event.place.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    if (isLiked) {
                      // Remove from favorites if unliked
                      mockUsers[0].favoritePlaces.remove(widget.event.place);
                    } else {
                      // Add to favorites if liked
                      mockUsers[0].favoritePlaces.add(widget.event.place);
                    }
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Event Time
          Text(
            '07.01.2024\n23:00 - 02:00',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          // Event Description
          Text(
            widget.event.description,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Participate Button
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
                color:
                widget.event.isParticipating ? Colors.orange : Colors.white,
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
