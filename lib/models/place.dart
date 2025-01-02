class Place {
  final String name;
  final String description;
  final String type; // "event center", "cafe", or "bar"
  final double x; // X-coordinate on the map
  final double y; // Y-coordinate on the map
  final String logo; // Image for the place

  Place({
    required this.name,
    required this.description,
    required this.type,
    required this.x,
    required this.y,
    required this.logo,
  });
}
