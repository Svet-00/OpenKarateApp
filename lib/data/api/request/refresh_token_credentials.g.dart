// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_credentials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshTokenCredentials _$RefreshTokenCredentialsFromJson(
    Map<String, dynamic> json) {
  return $checkedNew('RefreshTokenCredentials', json, () {
    final val = RefreshTokenCredentials(
      fingerprint: $checkedConvert(json, 'fingerprint', (v) => v as String),
      refreshToken: $checkedConvert(json, 'refresh_token', (v) => v as String),
    );
    return val;
  }, fieldKeyMap: const {'refreshToken': 'refresh_token'});
}

Map<String, dynamic> _$RefreshTokenCredentialsToJson(
    RefreshTokenCredentials instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fingerprint', instance.fingerprint);
  writeNotNull('refresh_token', instance.refreshToken);
  return val;
}
