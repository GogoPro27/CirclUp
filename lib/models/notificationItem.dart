class NotificationItem {
  final String message;
  final String timestamp;
  final String? profilePicture;
  final bool isActionable;
  final bool isSponsored;

  NotificationItem({
    required this.message,
    required this.timestamp,
    this.profilePicture,
    this.isActionable = false,
    this.isSponsored = false,
  });

  factory NotificationItem.fromMap(Map<String, dynamic> m) {
    return NotificationItem(
      message: (m['message'] ?? '') as String,
      timestamp: (m['timestamp'] ?? '') as String,
      profilePicture: m['profilePicture'] as String?,
      isActionable: (m['isActionable'] ?? false) as bool,
      isSponsored: (m['isSponsored'] ?? false) as bool,
    );
  }
}