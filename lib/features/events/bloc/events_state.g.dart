// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventsState _$EventsStateFromJson(Map<String, dynamic> json) {
  return $checkedNew('EventsState', json, () {
    final val = EventsState(
      criteria: $checkedConvert(
          json,
          'criteria',
          (v) => v == null
              ? null
              : EventsFilterCriteria.fromJson(v as Map<String, dynamic>)),
      pageStatus: $checkedConvert(
          json,
          'page_status',
          (v) => _$enumDecodeNullable(_$EventsStatusEnumMap, v,
              unknownValue: EventsStatus.initial)),
      events: $checkedConvert(
          json,
          'events',
          (v) => v == null
              ? null
              : EventsHolder.fromJson(v as Map<String, dynamic>)),
      filtered: $checkedConvert(
          json,
          'filtered',
          (v) => v == null
              ? null
              : EventsHolder.fromJson(v as Map<String, dynamic>)),
      selectedDate: $checkedConvert(json, 'selected_date',
          (v) => v == null ? null : DateTime.parse(v as String)),
      calendarFormat: $checkedConvert(json, 'calendar_format',
          (v) => _$enumDecodeNullable(_$CalendarFormatEnumMap, v)),
      calendarView: $checkedConvert(json, 'calendar_view', (v) => v as bool),
      errorMessage: $checkedConvert(json, 'error_message', (v) => v as String),
    );
    return val;
  }, fieldKeyMap: const {
    'pageStatus': 'page_status',
    'selectedDate': 'selected_date',
    'calendarFormat': 'calendar_format',
    'calendarView': 'calendar_view',
    'errorMessage': 'error_message'
  });
}

Map<String, dynamic> _$EventsStateToJson(EventsState instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page_status', _$EventsStatusEnumMap[instance.pageStatus]);
  writeNotNull('events', instance.events?.toJson());
  writeNotNull('filtered', instance.filtered?.toJson());
  writeNotNull(
      'calendar_format', _$CalendarFormatEnumMap[instance.calendarFormat]);
  writeNotNull('criteria', instance.criteria?.toJson());
  writeNotNull('calendar_view', instance.calendarView);
  writeNotNull('error_message', instance.errorMessage);
  writeNotNull('selected_date', instance.selectedDate?.toIso8601String());
  return val;
}

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$EventsStatusEnumMap = {
  EventsStatus.initial: 'initial',
  EventsStatus.success: 'success',
  EventsStatus.filtered: 'filtered',
};

const _$CalendarFormatEnumMap = {
  CalendarFormat.month: 'month',
  CalendarFormat.twoWeeks: 'twoWeeks',
  CalendarFormat.week: 'week',
};
