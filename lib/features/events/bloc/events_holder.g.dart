// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_holder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventsHolder _$EventsHolderFromJson(Map<String, dynamic> json) {
  return $checkedNew('EventsHolder', json, () {
    final val = EventsHolder(
      $checkedConvert(
          json,
          'set',
          (v) => (v as List)?.map((e) =>
              e == null ? null : Event.fromJson(e as Map<String, dynamic>))),
    );
    return val;
  });
}

Map<String, dynamic> _$EventsHolderToJson(EventsHolder instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('set', instance.set?.map((e) => e?.toJson())?.toList());
  return val;
}
