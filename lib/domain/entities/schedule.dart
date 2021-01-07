import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule.g.dart';

@JsonSerializable(nullable: false)
class Schedule extends Equatable {
  final String dayOfWeek;
  final String description;
  final String time;
  @JsonKey(name: 'gym')
  final String gymId;
  const Schedule({
    @required this.dayOfWeek,
    @required this.description,
    @required this.time,
    @required this.gymId,
  })  : assert(dayOfWeek != null),
        assert(description != null),
        assert(time != null),
        assert(gymId != null);

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      dayOfWeek,
      description,
      time,
      gymId,
    ];
  }

  Schedule copyWith({
    String dayOfWeek,
    String description,
    String time,
    String gymId,
  }) {
    return Schedule(
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      description: description ?? this.description,
      time: time ?? this.time,
      gymId: gymId ?? this.gymId,
    );
  }
}
