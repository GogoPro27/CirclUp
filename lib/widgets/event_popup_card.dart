import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event.dart';

class EventPopupCard extends StatefulWidget {
  final Event event;
  final VoidCallback onParticipationChanged;

  const EventPopupCard({
    super.key,
    required this.event,
    required this.onParticipationChanged,
  });

  @override
  State<EventPopupCard> createState() => _EventPopupCardState();
}

class _EventPopupCardState extends State<EventPopupCard> {
  final userRef = FirebaseFirestore.instance.collection("Users").doc("user1");
  List<String> userFavorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final doc = await userRef.get();
    setState(() {
      userFavorites = List<String>.from(doc.data()?["favoritePlaces"] ?? []);
    });
  }

  Future<void> _toggleFavorite(bool isLiked) async {
    if (isLiked) {
      await userRef.update({
        "favoritePlaces": FieldValue.arrayRemove([widget.event.place.name])
      });
    } else {
      await userRef.update({
        "favoritePlaces": FieldValue.arrayUnion([widget.event.place.name])
      });
    }
    await _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final isLiked = userFavorites.contains(widget.event.place.name);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Event image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              widget.event.eventImage,
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
                // Name + Like
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.event.place.name,
                        style: Theme.of(context).textTheme.titleLarge),
                    IconButton(
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : Colors.black87,
                      ),
                      onPressed: () => _toggleFavorite(isLiked),
                    ),
                  ],
                ),

                const SizedBox(height: 4),
                Text(widget.event.description,
                    style: Theme.of(context).textTheme.bodyMedium),

                const SizedBox(height: 8),
                Text("Participants: ${widget.event.attendees}"),

                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.event.isParticipating =
                      !widget.event.isParticipating;
                      widget.event.attendees +=
                      widget.event.isParticipating ? 1 : -1;
                    });
                    widget.onParticipationChanged();
                  },
                  child: Text(widget.event.isParticipating
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
