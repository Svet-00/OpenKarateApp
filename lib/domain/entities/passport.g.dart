// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Passport _$PassportFromJson(Map<String, dynamic> json) {
  return $checkedNew('Passport', json, () {
    final val = Passport(
      tokens: $checkedConvert(
          json, 'tokens', (v) => TokenPair.fromJson(v as Map<String, dynamic>)),
      user: $checkedConvert(
          json, 'user', (v) => User.fromJson(v as Map<String, dynamic>)),
    );
    return val;
  });
}

Map<String, dynamic> _$PassportToJson(Passport instance) => <String, dynamic>{
      'tokens': instance.tokens.toJson(),
      'user': instance.user.toJson(),
    };
