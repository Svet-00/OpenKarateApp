import '../entities/event.dart';

abstract class EventRepository {
  Future<List<Event>> fetchEvents();
  Future<void> participateInEvent(Event event);
}
