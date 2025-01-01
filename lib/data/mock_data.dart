import '../models/event.dart';

final List<Event> mockEvents = [
  Event(
    name: 'Stanica 26',
    description: 'A vibrant event center.',
    type: 'event center',
    attendees: 150,
    x: 3500,
    y: 1100,
    imagePath: 'assets/stanica.jpeg',
  ),
  Event(
    name: 'Kotur',
    description: 'A cozy bar.',
    type: 'bar',
    attendees: 75,
    x: 3185,
    y: 1683,
    imagePath: 'assets/kotur.png',
  ),
  Event(
    name: 'Papillon',
    description: 'A trendy cafe.',
    type: 'cafe',
    attendees: 40,
    x: 3588,
    y: 2011,
    imagePath: 'assets/papillon.png',
  ),
];