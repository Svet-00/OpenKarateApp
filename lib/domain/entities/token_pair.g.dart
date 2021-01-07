// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_pair.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenPair _$TokenPairFromJson(Map<String, dynamic> json) {
  return $checkedNew('TokenPair', json, () {
    final val = TokenPair(
      accessToken: $checkedConvert(json, 'access_token', (v) => v as String),
      refreshToken: $checkedConvert(json, 'refresh_token', (v) => v as String),
    );
    return val;
  }, fieldKeyMap: const {
    'accessToken': 'access_token',
    'refreshToken': 'refresh_token'
  });
}

Map<String, dynamic> _$TokenPairToJson(TokenPair instance) => <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
    };
