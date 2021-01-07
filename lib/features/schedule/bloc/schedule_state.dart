import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../core/utils/nullable.dart';
import '../../../domain/entities/gym.dart';
import '../../../domain/entities/schedule.dart';
import '../../../domain/page_status.dart';

part 'schedule_state.g.dart';

@JsonSerializable()
class ScheduleState extends Equatable {
  @JsonKey(unknownEnumValue: PageStatus.initial)
  final PageStatus pageStatus;
  final List<Gym> gyms;
  final List<Schedule> schedules;
  final String errorMessage;
  const ScheduleState({
    this.pageStatus = PageStatus.initial,
    this.gyms = const [],
    this.schedules = const [],
    this.errorMessage,
  })  : assert(pageStatus != null),
        assert(gyms != null),
        assert(schedules != null);

  factory ScheduleState.fromJson(Map<String, dynamic> json) =>
      _$ScheduleStateFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleStateToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [pageStatus, gyms, schedules, errorMessage];

  ScheduleState copyWith({
    PageStatus pageStatus,
    List<Gym> gyms,
    List<Schedule> schedules,
    Nullable<String> errorMessage,
  }) {
    return ScheduleState(
      pageStatus: pageStatus ?? this.pageStatus,
      gyms: gyms ?? this.gyms,
      schedules: schedules ?? this.schedules,
      errorMessage:
          errorMessage == null ? this.errorMessage : errorMessage.value,
    );
  }
}
