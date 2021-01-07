// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) {
  return $checkedNew('Schedule', json, () {
    final val = Schedule(
      dayOfWeek: $checkedConvert(json, 'day_of_week', (v) => v as String),
      description: $checkedConvert(json, 'description', (v) => v as String),
      time: $checkedConvert(json, 'time', (v) => v as String),
      gymId: $checkedConvert(json, 'gym', (v) => v as String),
    );
    return val;
  }, fieldKeyMap: const {'dayOfWeek': 'day_of_week', 'gymId': 'gym'});
}

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'day_of_week': instance.dayOfWeek,
      'description': instance.description,
      'time': instance.time,
      'gym': instance.gymId,
    };
