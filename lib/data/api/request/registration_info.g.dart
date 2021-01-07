// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../domain/models/registration_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationInfo _$RegistrationInfoFromJson(Map<String, dynamic> json) {
  return $checkedNew('RegistrationInfo', json, () {
    final val = RegistrationInfo(
      fingerprint: $checkedConvert(json, 'fingerprint', (v) => v as String),
      email: $checkedConvert(json, 'email', (v) => v as String),
      password: $checkedConvert(json, 'password', (v) => v as String),
      name: $checkedConvert(json, 'name', (v) => v as String),
      surname: $checkedConvert(json, 'surname', (v) => v as String),
      patronymic: $checkedConvert(json, 'patronymic', (v) => v as String),
      birthday: $checkedConvert(json, 'birthday',
          (v) => v == null ? null : DateTime.parse(v as String)),
      levelIndex: $checkedConvert(json, 'level', (v) => v as int),
    );
    return val;
  });
}

Map<String, dynamic> _$RegistrationInfoToJson(RegistrationInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fingerprint', instance.fingerprint);
  writeNotNull('email', instance.email);
  writeNotNull('password', instance.password);
  writeNotNull('name', instance.name);
  writeNotNull('surname', instance.surname);
  writeNotNull('patronymic', instance.patronymic);
  writeNotNull('birthday', instance.birthday?.toIso8601String());
  writeNotNull('level', instance.levelIndex);
  return val;
}
