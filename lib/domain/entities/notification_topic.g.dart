// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationTopic _$NotificationTopicFromJson(Map<String, dynamic> json) {
  return $checkedNew('NotificationTopic', json, () {
    final val = NotificationTopic(
      stringRepresentation:
          $checkedConvert(json, 'string_representation', (v) => v as String),
      description: $checkedConvert(json, 'description', (v) => v as String),
      subscribed:
          $checkedConvert(json, 'subscribed', (v) => v as bool) ?? false,
      important: $checkedConvert(json, 'important', (v) => v as bool) ?? false,
    );
    return val;
  }, fieldKeyMap: const {'stringRepresentation': 'string_representation'});
}

Map<String, dynamic> _$NotificationTopicToJson(NotificationTopic instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('string_representation', instance.stringRepresentation);
  writeNotNull('description', instance.description);
  writeNotNull('subscribed', instance.subscribed);
  writeNotNull('important', instance.important);
  return val;
}
