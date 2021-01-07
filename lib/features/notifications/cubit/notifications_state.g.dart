// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationsState _$NotificationsStateFromJson(Map<String, dynamic> json) {
  return $checkedNew('NotificationsState', json, () {
    final val = NotificationsState(
      topics: $checkedConvert(
          json,
          'topics',
          (v) => (v as List)
              ?.map((e) => e == null
                  ? null
                  : NotificationTopic.fromJson(e as Map<String, dynamic>))
              ?.toList()),
    );
    return val;
  });
}

Map<String, dynamic> _$NotificationsStateToJson(NotificationsState instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('topics', instance.topics?.map((e) => e?.toJson())?.toList());
  return val;
}
