import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/utils/nullable.dart';
import '../../../domain/entities/event.dart';
import 'events_holder.dart';

part 'events_state.g.dart';

enum EventsStatus { initial, success, filtered }

extension EventsStatusX on EventsStatus {
  bool get isInitial => this == EventsStatus.initial;
  bool get isSuccess => this == EventsStatus.success;
  bool get isFiltered => this == EventsStatus.filtered;
}

@JsonSerializable()
class EventsState extends Equatable {
  @JsonKey(unknownEnumValue: EventsStatus.initial)
  final EventsStatus pageStatus;
  final EventsHolder events;
  final EventsHolder filtered;
  final CalendarFormat calendarFormat;
  final EventsFilterCriteria criteria;
  final bool calendarView;
  final String errorMessage;
  final DateTime selectedDate;

  EventsState({
    EventsFilterCriteria criteria,
    this.pageStatus = EventsStatus.initial,
    @required this.events,
    @required this.filtered,
    this.selectedDate,
    this.calendarFormat = CalendarFormat.week,
    this.calendarView = true,
    this.errorMessage,
  })  : criteria = criteria ?? EventsFilterCriteria(),
        assert(pageStatus != null),
        assert(calendarView != null),
        assert(events != null),
        assert(filtered != null),
        assert(calendarFormat != null);

  factory EventsState.fromJson(Map<String, dynamic> json) =>
      _$EventsStateFromJson(json);

  Map<String, dynamic> toJson() => _$EventsStateToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      pageStatus,
      events,
      filtered,
      selectedDate,
      calendarFormat,
      criteria,
      calendarView,
      errorMessage,
    ];
  }

  EventsState copyWith({
    EventsStatus pageStatus,
    EventsHolder events,
    EventsHolder filtered,
    CalendarFormat calendarFormat,
    EventsFilterCriteria criteria,
    bool calendarView,
    Nullable<String> errorMessage,
    Nullable<DateTime> selectedDate,
  }) {
    return EventsState(
      pageStatus: pageStatus ?? this.pageStatus,
      events: events ?? this.events,
      filtered: filtered ?? this.filtered,
      calendarFormat: calendarFormat ?? this.calendarFormat,
      criteria: criteria ?? this.criteria,
      calendarView: calendarView ?? this.calendarView,
      errorMessage:
          errorMessage == null ? this.errorMessage : errorMessage.value,
      selectedDate:
          selectedDate == null ? this.selectedDate : selectedDate.value,
    );
  }
}
