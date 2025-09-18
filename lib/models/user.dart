import 'place.dart';

class User {
  final String name;
  final String profilePicture;
  final String coverPhoto;
  final String bio;
  final String phoneNumber;
  final String email;
  final String gender;
  final DateTime dateOfBirth;
  int coins;
  final List<User> friends;
  final List<String> posts;
  final List<Place> favoritePlaces;

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

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: (map['name'] ?? '') as String,
      profilePicture: (map['profilePicture'] ?? '') as String,
      coverPhoto: (map['coverPhoto'] ?? '') as String,
      bio: (map['bio'] ?? '') as String,
      phoneNumber: (map['phoneNumber'] ?? '') as String,
      email: (map['email'] ?? '') as String,
      gender: (map['gender'] ?? '') as String,
      dateOfBirth: DateTime.tryParse(map['dateOfBirth'] ?? '') ?? DateTime.now(),
      coins: (map['coins'] ?? 0) as int,
      friends: [], // populate separately if you have user relations
      posts: List<String>.from(map['posts'] ?? []),
      favoritePlaces: (map['favoritePlaces'] as List<dynamic>? ?? [])
          .map((p) => Place.fromMap(p as Map<String, dynamic>))
          .toList(),
    );
  }
}
