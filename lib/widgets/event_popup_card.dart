import 'package:flutter/material.dart';
import '../models/event.dart';

class EventPopupCard extends StatelessWidget {
  final Event event;
  final VoidCallback onParticipationChanged;

  const EventPopupCard({
    super.key,
    required this.event,
    required this.onParticipationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Event image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              event.eventImage,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event.place.name,
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 4),
                Text(event.description,
                    style: Theme.of(context).textTheme.bodyMedium),

                const SizedBox(height: 8),
                Text("Participants: ${event.attendees}"),

                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    event.isParticipating = !event.isParticipating;
                    event.attendees += event.isParticipating ? 1 : -1;
                    onParticipationChanged();
                  },
                  child: Text(event.isParticipating
                      ? "Cancel Participation"
                      : "Participate"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
