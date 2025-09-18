import 'place.dart';

class Event {
  final String description;
  int attendees;
  bool isParticipating;
  final Place place;
  final String eventImage;

  Event({
    required this.description,
    required this.attendees,
    this.isParticipating = false,
    required this.place,
    required this.eventImage,
  });

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      description: (map['description'] ?? '') as String,
      attendees: (map['attendees'] ?? 0) as int,
      isParticipating: (map['isParticipating'] ?? false) as bool,
      place: Place.fromMap(map['place'] ?? {}),
      eventImage: (map['eventImage'] ?? '') as String,
    );
  }
}
