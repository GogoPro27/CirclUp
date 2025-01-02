class Event {
  final String name;
  final String description;
  final String type;
  int attendees;
  final double x;
  final double y;
  final String imagePath;
  final String photoUrl;
  bool isParticipating; // New property

  Event({
    required this.name,
    required this.description,
    required this.type,
    required this.attendees,
    required this.x,
    required this.y,
    required this.imagePath,
    required this.photoUrl,
    this.isParticipating = false, // Default value
  });
}