class Place {
  final String name;
  final String description;
  final String type;
  final double x; // latitude
  final double y; // longitude
  final String logo;

  Place({
    required this.name,
    required this.description,
    required this.type,
    required this.x,
    required this.y,
    required this.logo,
  });

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      name: (map['name'] ?? '') as String,
      description: (map['description'] ?? '') as String,
      type: (map['type'] ?? '') as String,
      x: (map['x'] ?? 0).toDouble(),
      y: (map['y'] ?? 0).toDouble(),
      logo: (map['logo'] ?? '') as String,
    );
  }
}
