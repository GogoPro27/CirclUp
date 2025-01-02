import 'place.dart';

class User {
  final String name; // Full name
  final String profilePicture; // Profile picture path
  final String coverPhoto; // Cover photo path
  final String bio; // Short bio
  int coins; // In-app currency, default is 0
  final List<User> friends; // List of friends
  final List<String> posts; // List of photo paths posted on the profile
  final List<Place> favoritePlaces; // User's liked places

  User({
    required this.name,
    required this.profilePicture,
    required this.coverPhoto,
    required this.bio,
    this.coins = 0,
    required this.friends,
    required this.posts,
    required this.favoritePlaces,
  });
}
