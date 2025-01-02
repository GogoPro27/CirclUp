import '../models/event.dart';

class FilterService {
  static List<Event> applyFilters(List<Event> events, Map<String, bool> filters) {
    if (filters['All'] == true) {
      return events;
    }
    return events.where((event) => filters[event.place.type] == true).toList();
  }
}
