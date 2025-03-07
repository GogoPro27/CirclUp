import 'place.dart';

class User {
  final String name; // Full name
  final String profilePicture; // Profile picture path
  final String coverPhoto; // Cover photo path
  final String bio; // Short bio
  final String phoneNumber; // User's phone number
  final String email; // User's email
  final String gender; // User's gender (e.g., "Male", "Female", "Other")
  final DateTime dateOfBirth; // User's date of birth
  int coins; // In-app currency, default is 0
  final List<User> friends; // List of friends
  final List<String> posts; // List of photo paths posted on the profile
  final List<Place> favoritePlaces; // User's liked places

  User({
    required this.name,
    required this.profilePicture,
    required this.coverPhoto,
    required this.bio,
    required this.phoneNumber,
    required this.email,
    required this.gender,
    required this.dateOfBirth,
    this.coins = 0,
    required this.friends,
    required this.posts,
    required this.favoritePlaces,
  });
}
