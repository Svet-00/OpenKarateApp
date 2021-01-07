import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../core/utils/datetime_x.dart';
import 'document.dart';
import 'link.dart';

part 'event.g.dart';

@JsonSerializable()
class Event extends Equatable {
  final String id;
  final String title;
  final String description;
  final String address;
  final DateTime startDate;
  final DateTime endDate;
  final bool isCanceled;
  @JsonKey(defaultValue: '')
  final String type;
  @JsonKey(defaultValue: '')
  final String level;
  @JsonKey(defaultValue: [])
  final List<Document> documents;
  @JsonKey(defaultValue: [])
  final List<Link> links;
  const Event({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.address,
    @required this.startDate,
    @required this.endDate,
    @required this.isCanceled,
    this.type = '',
    this.level = '',
    this.documents = const [],
    this.links = const [],
  })  : assert(id != null),
        assert(title != null),
        assert(address != null),
        assert(startDate != null),
        assert(endDate != null),
        assert(isCanceled != null),
        assert(type != null),
        assert(level != null),
        assert(documents != null),
        assert(links != null);

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      title,
      description,
      address,
      startDate,
      endDate,
      isCanceled,
      type,
      level,
      documents,
      links,
    ];
  }

  Event copyWith({
    String id,
    String title,
    String description,
    String address,
    DateTime startDate,
    DateTime endDate,
    bool isCanceled,
    String type,
    String level,
    List<Document> documents,
    List<Link> links,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      address: address ?? this.address,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCanceled: isCanceled ?? this.isCanceled,
      type: type ?? this.type,
      level: level ?? this.level,
      documents: documents ?? this.documents,
      links: links ?? this.links,
    );
  }

  static int startDateComparator(Event a, Event b) {
    final start = a.startDate.compareTo(b.startDate);
    if (start != 0) {
      return start;
    } else {
      final end = a.endDate.compareTo(b.endDate);
      // first show events which end later
      // if ends at the same time, order does not matter
      return end != 0 ? -1 * end : -1;
    }
  }
}

@JsonSerializable(nullable: false)
class EventsFilterCriteria extends Equatable {
  final String type;
  final String level;
  final DateTime startDate;
  final DateTime endDate;

  static final anyType = 'Любой';
  static final anyLevel = 'Любой';

  EventsFilterCriteria({
    String type,
    String level,
    DateTime startDate,
    DateTime endDate,
  })  : type = type ?? anyType,
        level = level ?? anyLevel,
        startDate = startDate ??
            DateTime.now().subtract(const Duration(days: 365)).toDate(),
        endDate =
            endDate ?? DateTime.now().add(const Duration(days: 365)).toDate();

  factory EventsFilterCriteria.fromJson(Map<String, dynamic> json) =>
      _$EventsFilterCriteriaFromJson(json);

  Map<String, dynamic> toJson() => _$EventsFilterCriteriaToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [type, level, startDate, endDate];

  EventsFilterCriteria copyWith({
    String type,
    String level,
    DateTime startDate,
    DateTime endDate,
  }) {
    return EventsFilterCriteria(
      type: type ?? this.type,
      level: level ?? this.level,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
