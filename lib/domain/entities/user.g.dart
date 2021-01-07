// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return $checkedNew('User', json, () {
    final val = User(
      id: $checkedConvert(json, 'id', (v) => v as String),
      email: $checkedConvert(json, 'email', (v) => v as String),
      name: $checkedConvert(json, 'name', (v) => v as String),
      surname: $checkedConvert(json, 'surname', (v) => v as String),
      avatar: $checkedConvert(
          json,
          'avatar',
          (v) => v == null
              ? null
              : UserAvatar.fromJson(v as Map<String, dynamic>)),
      level: $checkedConvert(json, 'level', (v) => v as int),
      birthday: $checkedConvert(json, 'birthday',
          (v) => v == null ? null : DateTime.parse(v as String)),
      groups: $checkedConvert(json, 'groups',
              (v) => (v as List)?.map((e) => e as String)?.toList()) ??
          [],
      isAdmin: $checkedConvert(json, 'admin', (v) => v as bool) ?? false,
      isTrainer: $checkedConvert(json, 'trainer', (v) => v as bool),
      eventIds: $checkedConvert(json, 'events',
              (v) => (v as List)?.map((e) => e as int)?.toList()) ??
          [],
      patronymic: $checkedConvert(json, 'patronymic', (v) => v as String),
      shortDescription:
          $checkedConvert(json, 'short_description', (v) => v as String),
      longDescription:
          $checkedConvert(json, 'long_description', (v) => v as String),
      weight: $checkedConvert(json, 'weight', (v) => (v as num)?.toDouble()),
    );
    return val;
  }, fieldKeyMap: const {
    'isAdmin': 'admin',
    'isTrainer': 'trainer',
    'eventIds': 'events',
    'shortDescription': 'short_description',
    'longDescription': 'long_description'
  });
}

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('email', instance.email);
  writeNotNull('name', instance.name);
  writeNotNull('surname', instance.surname);
  writeNotNull('avatar', instance.avatar?.toJson());
  writeNotNull('level', instance.level);
  writeNotNull('birthday', instance.birthday?.toIso8601String());
  writeNotNull('groups', instance.groups);
  writeNotNull('admin', instance.isAdmin);
  writeNotNull('trainer', instance.isTrainer);
  writeNotNull('events', instance.eventIds);
  writeNotNull('patronymic', instance.patronymic);
  writeNotNull('short_description', instance.shortDescription);
  writeNotNull('long_description', instance.longDescription);
  writeNotNull('weight', instance.weight);
  return val;
}

UserAvatar _$UserAvatarFromJson(Map<String, dynamic> json) {
  return $checkedNew('UserAvatar', json, () {
    final val = UserAvatar(
      square: $checkedConvert(json, 'square', (v) => v as String),
      wide: $checkedConvert(json, 'wide', (v) => v as String),
    );
    return val;
  });
}

Map<String, dynamic> _$UserAvatarToJson(UserAvatar instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('square', instance.square);
  writeNotNull('wide', instance.wide);
  return val;
}
