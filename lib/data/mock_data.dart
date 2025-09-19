import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:circl_up_app/models/coupon.dart';

import '../models/event.dart';
import '../models/notificationItem.dart';
import '../models/place.dart';
import '../models/user.dart';

final List<Place> mockPlaces = [];
final List<Event> mockEvents = [];
final List<User> mockUsers = [];
final List<Coupon> mockCoupons = [];

final List<NotificationItem> mockNotifications = [];

Future<void> loadMockData() async {
  final db = FirebaseFirestore.instance;

  try {
    final placesSnap = await db.collection('Places').get();
    final Map<String, Place> placeMap = {};
    final Map<String, Place> placeNameMap = {};
    mockPlaces
      ..clear()
      ..addAll(placesSnap.docs.map((d) {
        final p = Place.fromMap(d.data());
        placeMap[d.id] = p;
        final nameKey = (p.name ?? '').trim().toLowerCase();
        if (nameKey.isNotEmpty) placeNameMap[nameKey] = p;
        return p;
      }).toList());

    final usersSnap = await db.collection('Users').get();
    final Map<String, User> userMap = {};
    final Map<String, List<dynamic>> rawFriends = {};
    mockUsers.clear();

    for (var d in usersSnap.docs) {
      final m = d.data();

      rawFriends[d.id] = List<dynamic>.from(m['friends'] ?? []);

      final user = User(
        name: (m['name'] ?? '') as String,
        profilePicture: (m['profilePicture'] ?? '') as String,
        coverPhoto: (m['coverPhoto'] ?? '') as String,
        bio: (m['bio'] ?? '') as String,
        phoneNumber: (m['phoneNumber'] ?? '') as String,
        email: (m['email'] ?? '') as String,
        gender: (m['gender'] ?? '') as String,
        dateOfBirth: DateTime.tryParse(m['dateOfBirth'] ?? '') ?? DateTime.now(),
        coins: (m['coins'] ?? 0) as int,
        friends: [],
        posts: List<String>.from(m['posts'] ?? []),
        favoritePlaces: [],
      );

      userMap[d.id] = user;
      mockUsers.add(user);
    }

    final eventsSnap = await db.collection('Events').get();
    mockEvents
      ..clear()
      ..addAll(eventsSnap.docs.map((d) {
        final m = d.data();
        final dynamic placeField = m['place'];

        Place placeResolved;
        if (placeField is DocumentReference) {
          placeResolved = placeMap[placeField.id] ?? Place.fromMap({});
        } else if (placeField is Map<String, dynamic>) {
          placeResolved = Place.fromMap(placeField);
        } else if (placeField is String) {
          final key = placeField.trim().toLowerCase();
          placeResolved = placeNameMap[key] ?? placeMap[placeField] ?? Place.fromMap({});
        } else {
          placeResolved = Place.fromMap({});
        }

        return Event(
          description: (m['description'] ?? '') as String,
          attendees: (m['attendees'] ?? 0) as int,
          isParticipating: (m['isParticipating'] ?? false) as bool,
          place: placeResolved,
          eventImage: (m['eventImage'] ?? '') as String,
        );
      }).toList());

    final couponsSnap = await db.collection('Coupons').get();
    mockCoupons
      ..clear()
      ..addAll(couponsSnap.docs.map((d) => Coupon.fromMap(d.data())).toList());

    final notificationsSnap = await db.collection('NotificationItems').get();
    mockNotifications
      ..clear()
      ..addAll(notificationsSnap.docs.map((d) {
        final m = d.data();
        return NotificationItem.fromMap(m);
      }).toList());

    rawFriends.forEach((userId, list) {
      final u = userMap[userId];
      if (u == null) return;

      for (var f in list) {
        if (f is String) {
          final targetName = f.trim().toLowerCase();
          try {
            final friend = mockUsers.firstWhere(
              (mu) => mu.name.trim().toLowerCase() == targetName,
            );
            // avoid self-references and duplicates
            if (friend != u && !u.friends.contains(friend)) {
              u.friends.add(friend);
            }
          } catch (_) {
          }
        } else if (f is DocumentReference) {
          final friend = userMap[f.id];
          if (friend != null && friend != u && !u.friends.contains(friend)) {
            u.friends.add(friend);
          }
        } else if (f is Map<String, dynamic>) {
          final nestedName = ((f['name'] ?? '') as String).trim().toLowerCase();
          if (nestedName.isNotEmpty) {
            try {
              final friend = mockUsers.firstWhere(
                (mu) => mu.name.trim().toLowerCase() == nestedName,
              );
              if (friend != u && !u.friends.contains(friend)) {
                u.friends.add(friend);
              }
            } catch (_) {
            }
          }
        }
      }
    });

    print('✅ Mock data loaded from Firestore successfully.');
  } catch (e, st) {
    print('❌ Error loading mock data from Firestore: $e\n$st');
  }
}
