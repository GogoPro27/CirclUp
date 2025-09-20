import 'package:flutter/material.dart';
import '../models/event.dart';
import '../data/data.dart';

class EventDetailsBottomSheet extends StatefulWidget {
  final Event event;
  final VoidCallback onParticipationChanged;
  final VoidCallback? onClose; // <- so MapScreen can close the card

  const EventDetailsBottomSheet({
    Key? key,
    required this.event,
    required this.onParticipationChanged,
    this.onClose,
  }) : super(key: key);

  @override
  State<EventDetailsBottomSheet> createState() =>
      _EventDetailsBottomSheetState();
}

class _EventDetailsBottomSheetState extends State<EventDetailsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    // is the place in favorites?
    bool isLiked = mockUsers[0].favoritePlaces.contains(widget.event.place);

    final BorderRadius imgRadius = BorderRadius.circular(20);

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
          // Top row: back arrow (left) + heart (right)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                visualDensity: VisualDensity.compact,
                icon: const Icon(Icons.arrow_back, color: Colors.black87),
                onPressed: widget.onClose ?? () => Navigator.pop(context),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.black87,
                ),
                onPressed: () {
                  setState(() {
                    if (isLiked) {
                      mockUsers[0].favoritePlaces.remove(widget.event.place);
                    } else {
                      mockUsers[0].favoritePlaces.add(widget.event.place);
                    }
                  });
                },
              ),
            ],
          ),

          // Image with orange border and rounded corners
          Container(
            decoration: BoxDecoration(
              borderRadius: imgRadius,
              border: Border.all(color: Colors.orange, width: 4),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              widget.event.eventImage,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 16),

          // Title
          Text(
            widget.event.place.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              // soft shadow like your screenshot
              shadows: [Shadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
            ),
          ),

          const SizedBox(height: 8),

          // Time (static demo)
          const Text(
            '07.01.2024\n23:00 - 02:00',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),

          const SizedBox(height: 8),

          // Description
          Text(
            widget.event.description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 16),

          // Participate / Cancel
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (widget.event.isParticipating) {
                  widget.event.attendees--;
                } else {
                  widget.event.attendees++;
                }
                widget.event.isParticipating = !widget.event.isParticipating;
                widget.onParticipationChanged();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
              widget.event.isParticipating ? Colors.white : Colors.orange,
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
                color: widget.event.isParticipating
                    ? Colors.orange
                    : Colors.white,
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
