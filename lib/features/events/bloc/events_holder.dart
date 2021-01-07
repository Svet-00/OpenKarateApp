import 'dart:collection';

import 'package:json_annotation/json_annotation.dart';

import '../../../core/utils/datetime_x.dart';
import '../../../domain/entities/event.dart';

part 'events_holder.g.dart';

/// Lazily generates events map
/// and maintains it's consistency with list
@JsonSerializable()
class EventsHolder {
  @JsonKey(ignore: true)
  Map<DateTime, List<Event>> _map;
  Map<DateTime, List<Event>> get map {
    return _map ??= _generateEventMap(dates);
  }

  @JsonKey(ignore: true)
  List<DateTime> _dates;
  List<DateTime> get dates {
    return _dates ??= _getEventsUniqueDates(set);
  }

  final SplayTreeSet<Event> _set;
  SplayTreeSet<Event> get set => _set;

  EventsHolder._(this._set);
  EventsHolder(Iterable<Event> set)
      : assert(set != null),
        _set = SplayTreeSet.of(set, Event.startDateComparator);

  List<Event> forDate(DateTime date) => map[date?.toDate()] ?? [];

  Map<DateTime, List<Event>> _generateEventMap(Iterable<DateTime> dates) {
    final result = HashMap<DateTime, List<Event>>(
      equals: (a, b) => a.compareTo(b) == 0,
    );

    for (var date in dates) {
      final filtered = set.where((e) {
        // event starting at `date`
        return e.startDate.toDate().isAtSameMomentAs(date) ||
            // event ending at `date`
            e.endDate.toDate().isAtSameMomentAs(date) ||
            // event is 3+ days long and `date` is between start and end
            (e.startDate.toDate().isBefore(date) &&
                e.endDate.toDate().isAfter(date));
      }).toList();
      if (filtered.isNotEmpty) {
        result[date] = filtered;
      }
    }
    return result;
  }

  List<DateTime> _getEventsUniqueDates(Iterable<Event> events) {
    final result = SplayTreeSet<DateTime>();
    final day = const Duration(days: 1);

    events.forEach((e) {
      var currentDate = e.startDate.toDate();
      result.add(currentDate);
      while (currentDate.compareTo(e.endDate.toDate()) <= 0) {
        result.add(currentDate);
        currentDate = currentDate.add(day);
      }
    });

    return result.toList(growable: false);
  }

  Map<String, dynamic> toJson() => _$EventsHolderToJson(this);
  factory EventsHolder.fromJson(Map<String, dynamic> json) =>
      _$EventsHolderFromJson(json);

  factory EventsHolder._copy(
    Map<DateTime, List<Event>> _map,
    List<DateTime> _dates,
    SplayTreeSet<Event> _set,
  ) {
    final copy = EventsHolder._(_set);
    copy._map = _map;
    copy._dates = _dates;
    return copy;
  }
}
