import '../models/event.dart';
import '../models/place.dart';

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
    eventImage: 'assets/stanica_zgrada.jpg', // Event-specific image
  ),
  Event(
    description: 'A night full of laughter with top comedians.',
    attendees: 50,
    isParticipating: false,
    place: mockPlaces[1], // Reference to Kotur
    eventImage: 'assets/stanica_zgrada.jpg', // Event-specific image
  ),
  Event(
    description: 'A casual coffee meetup.',
    attendees: 30,
    isParticipating: false,
    place: mockPlaces[2], // Reference to Papillon
    eventImage: 'assets/stanica_zgrada.jpg', // Event-specific image
  ),
];

