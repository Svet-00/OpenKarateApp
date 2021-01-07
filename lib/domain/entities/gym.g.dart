// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gym.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gym _$GymFromJson(Map<String, dynamic> json) {
  return $checkedNew('Gym', json, () {
    final val = Gym(
      id: $checkedConvert(json, 'id', (v) => v as String),
      address: $checkedConvert(json, 'address', (v) => v as String),
      title: $checkedConvert(json, 'title', (v) => v as String),
      description:
          $checkedConvert(json, 'description', (v) => v as String) ?? '',
      workingTime: $checkedConvert(json, 'working_time', (v) => v as String),
      phoneNumber: $checkedConvert(json, 'phone_number', (v) => v as String),
      email: $checkedConvert(json, 'email', (v) => v as String),
      vkLink: $checkedConvert(json, 'vk_link', (v) => v as String),
      photos: $checkedConvert(
              json,
              'photos',
              (v) => (v as List)
                  ?.map((e) => e == null
                      ? null
                      : Photo.fromJson(e as Map<String, dynamic>))
                  ?.toList()) ??
          [],
      isFavorite:
          $checkedConvert(json, 'is_favorite', (v) => v as bool) ?? false,
    );
    return val;
  }, fieldKeyMap: const {
    'workingTime': 'working_time',
    'phoneNumber': 'phone_number',
    'vkLink': 'vk_link',
    'isFavorite': 'is_favorite'
  });
}

Map<String, dynamic> _$GymToJson(Gym instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('address', instance.address);
  writeNotNull('title', instance.title);
  writeNotNull('description', instance.description);
  writeNotNull('working_time', instance.workingTime);
  writeNotNull('phone_number', instance.phoneNumber);
  writeNotNull('email', instance.email);
  writeNotNull('vk_link', instance.vkLink);
  writeNotNull('photos', instance.photos?.map((e) => e?.toJson())?.toList());
  writeNotNull('is_favorite', instance.isFavorite);
  return val;
}
