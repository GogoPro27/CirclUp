import 'package:circl_up_app/models/coupon.dart';

import '../models/event.dart';
import '../models/place.dart';
import '../models/user.dart';

// Mock Places
final List<Place> mockPlaces = [
  Place(
    name: 'Stanica 26',
    description: 'A vibrant event center known for nightlife and concerts.',
    type: 'event center',
    x: 3500,
    y: 1100,
    logo: 'assets/stanica.jpeg',
  ),
  Place(
    name: 'Kotur',
    description: 'A cozy bar with a unique atmosphere.',
    type: 'bar',
    x: 3185,
    y: 1683,
    logo: 'assets/kotur.png',
  ),
  Place(
    name: 'Papillon',
    description: 'A trendy cafe for gatherings.',
    type: 'cafe',
    x: 3588,
    y: 2011,
    logo: 'assets/papillon.png',
  ),
];

final List<Event> mockEvents = [
  Event(
    description: 'An electrifying DJ performance.',
    attendees: 200,
    isParticipating: false,
    place: mockPlaces[0], // Reference to Stanica 26
    eventImage: 'assets/stanica_zgrada.jpg',
  ),
  Event(
    description: 'A night full of laughter with top comedians.',
    attendees: 50,
    isParticipating: false,
    place: mockPlaces[1], // Reference to Kotur
    eventImage: 'assets/stanica_zgrada.jpg',
  ),
  Event(
    description: 'A casual coffee meetup.',
    attendees: 30,
    isParticipating: false,
    place: mockPlaces[2], // Reference to Papillon
    eventImage: 'assets/stanica_zgrada.jpg',
  ),
];

final List<User> mockUsers = [
  User(
    name: "Nidzo Aerodrom",
    profilePicture: 'assets/nidzo_picture.png',
    coverPhoto: 'assets/mzt.png',
    bio: "Аеродром во душа",
    coins: 1440,
    friends: [], // Initialize as empty
    posts: [
      'assets/pp1.png',
      'assets/pp2.png',
      'assets/pp3.png',
      'assets/pp4.png',
      'assets/pp5.png',
    ],
    favoritePlaces: [],
  ),
  User(
    name: "Samantha Phil",
    profilePicture: 'assets/samantha_picture.png',
    coverPhoto: '',
    bio: "Lover of bar trivia nights and relaxing cafes.",
    coins: 200,
    friends: [], // Initialize as empty
    posts: [],
    favoritePlaces: [],
  ),
  User(
    name: "John Doe",
    profilePicture: 'assets/john_picture.png',
    coverPhoto: 'assets/alice_cover.jpg',
    bio: "Explorer of hidden gems in the city.",
    coins: 50,
    friends: [], // Initialize as empty
    posts: [],
    favoritePlaces: [],
  ),
];

// Function to Initialize Friends
void initializeUserFriends() {
  mockUsers[0].friends.add(mockUsers[1]); // Nidzo is friends with Samantha
  mockUsers[0].friends.add(mockUsers[2]); // Nidzo is friends with John
  mockUsers[1].friends.add(mockUsers[0]); // Samantha is friends with Nidzo
  mockUsers[2].friends.add(mockUsers[0]); // John is friends with Nidzo
}


final List<Coupon> mockCoupons = [
  Coupon(
    description: 'Ananas Gift Card worth 1000 den.',
    photo: 'assets/ananas.png',
    cost: 800,
    qrCode: 'assets/qr.png',
  ),
  Coupon(
    description: 'Buy Prime Subscription for 1000 circles',
    photo: 'assets/ananas.png',
    cost: 1000,
    qrCode: 'assets/qr.png',
  ),
  Coupon(
    description: 'Burger King Coupon worth 500 den.',
    photo: 'assets/burger_king.png',
    cost: 300,
    qrCode: 'assets/qr.png',
  ),
];

class NotificationItem {
  final String message;
  final String timestamp;
  final String? profilePicture; // Optional for user profile pictures
  final bool isActionable; // For Accept/Decline buttons
  final bool isSponsored; // For sponsored content

  NotificationItem({
    required this.message,
    required this.timestamp,
    this.profilePicture,
    this.isActionable = false,
    this.isSponsored = false,
  });
}

final List<NotificationItem> mockNotifications = [
  NotificationItem(
    message: "Samantha Phil requested to join your circle!",
    timestamp: "2m",
    profilePicture: "assets/samantha_picture.png",
    isActionable: true,
  ),
  NotificationItem(
    message: "You have received 100 circles from circl'in up with 2 people.",
    timestamp: "2h",
    profilePicture: "assets/stanica.jpeg",
  ),
  NotificationItem(
    message: "John Doe thinks your photo is great!",
    timestamp: "40m",
    profilePicture: "assets/john_picture.png",
  ),
  NotificationItem(
    message: "John Doe accepted you in their circle.",
    timestamp: "1h",
    profilePicture: "assets/john_picture.png",
  ),
  NotificationItem(
    message: "Unforgettable night at Stanica 26 on 07.01 at 11pm.",
    timestamp: "2h",
    profilePicture: "assets/stanica.jpeg",
  ),
  NotificationItem(
    message: "Cocktails night at Kotur tonight, all drinks are 20% off.",
    timestamp: "3h",
    profilePicture: "assets/kotur.png",
    isSponsored: true,
  ),
];