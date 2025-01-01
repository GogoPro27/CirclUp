class Event {
  final String name;
  final String description;
  final String type; // e.g., "bar", "cafe", "event center"
  final int attendees; // Number of attendees
  final double x; // X coordinate on the map
  final double y; // Y coordinate on the map
  final String imagePath; // Path to the event image

  Event({
    required this.name,
    required this.description,
    required this.type,
    required this.attendees,
    required this.x,
    required this.y,
    required this.imagePath,
  });
}