// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credentials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Credentials _$CredentialsFromJson(Map<String, dynamic> json) {
  return $checkedNew('Credentials', json, () {
    final val = Credentials(
      fingerprint: $checkedConvert(json, 'fingerprint', (v) => v as String),
      email: $checkedConvert(json, 'email', (v) => v as String),
      password: $checkedConvert(json, 'password', (v) => v as String),
    );
    return val;
  });
}

Map<String, dynamic> _$CredentialsToJson(Credentials instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fingerprint', instance.fingerprint);
  writeNotNull('email', instance.email);
  writeNotNull('password', instance.password);
  return val;
}
