import 'place.dart';

class Event {
  final String description; // Description of the event
  int attendees; // Number of attendees
  bool isParticipating; // Whether the user is participating
  final Place place; // Associated place for the event
  final String eventImage; // Event-specific image

  Event({
    required this.description,
    required this.attendees,
    this.isParticipating = false,
    required this.place,
    required this.eventImage, // New property
  });
}
