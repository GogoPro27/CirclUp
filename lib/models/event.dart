class Event {
  final String name;
  final String description;
  final String type;
  final int attendees;
  final double x;
  final double y;
  final String imagePath;
  final String photoUrl; // New property

  Event({
    required this.name,
    required this.description,
    required this.type,
    required this.attendees,
    required this.x,
    required this.y,
    required this.imagePath,
    required this.photoUrl, // Initialize new property
  });
}