// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return $checkedNew('Event', json, () {
    final val = Event(
      id: $checkedConvert(json, 'id', (v) => v as String),
      title: $checkedConvert(json, 'title', (v) => v as String),
      description: $checkedConvert(json, 'description', (v) => v as String),
      address: $checkedConvert(json, 'address', (v) => v as String),
      startDate: $checkedConvert(json, 'start_date',
          (v) => v == null ? null : DateTime.parse(v as String)),
      endDate: $checkedConvert(json, 'end_date',
          (v) => v == null ? null : DateTime.parse(v as String)),
      isCanceled: $checkedConvert(json, 'is_canceled', (v) => v as bool),
      type: $checkedConvert(json, 'type', (v) => v as String) ?? '',
      level: $checkedConvert(json, 'level', (v) => v as String) ?? '',
      documents: $checkedConvert(
              json,
              'documents',
              (v) => (v as List)
                  ?.map((e) => e == null
                      ? null
                      : Document.fromJson(e as Map<String, dynamic>))
                  ?.toList()) ??
          [],
      links: $checkedConvert(
              json,
              'links',
              (v) => (v as List)
                  ?.map((e) => e == null
                      ? null
                      : Link.fromJson(e as Map<String, dynamic>))
                  ?.toList()) ??
          [],
    );
    return val;
  }, fieldKeyMap: const {
    'startDate': 'start_date',
    'endDate': 'end_date',
    'isCanceled': 'is_canceled'
  });
}

Map<String, dynamic> _$EventToJson(Event instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('description', instance.description);
  writeNotNull('address', instance.address);
  writeNotNull('start_date', instance.startDate?.toIso8601String());
  writeNotNull('end_date', instance.endDate?.toIso8601String());
  writeNotNull('is_canceled', instance.isCanceled);
  writeNotNull('type', instance.type);
  writeNotNull('level', instance.level);
  writeNotNull(
      'documents', instance.documents?.map((e) => e?.toJson())?.toList());
  writeNotNull('links', instance.links?.map((e) => e?.toJson())?.toList());
  return val;
}

EventsFilterCriteria _$EventsFilterCriteriaFromJson(Map<String, dynamic> json) {
  return $checkedNew('EventsFilterCriteria', json, () {
    final val = EventsFilterCriteria(
      type: $checkedConvert(json, 'type', (v) => v as String),
      level: $checkedConvert(json, 'level', (v) => v as String),
      startDate: $checkedConvert(
          json, 'start_date', (v) => DateTime.parse(v as String)),
      endDate:
          $checkedConvert(json, 'end_date', (v) => DateTime.parse(v as String)),
    );
    return val;
  }, fieldKeyMap: const {'startDate': 'start_date', 'endDate': 'end_date'});
}

Map<String, dynamic> _$EventsFilterCriteriaToJson(
        EventsFilterCriteria instance) =>
    <String, dynamic>{
      'type': instance.type,
      'level': instance.level,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
    };
