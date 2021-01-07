// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_exceptions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerException _$ServerExceptionFromJson(Map<String, dynamic> json) {
  return $checkedNew('ServerException', json, () {
    final val = ServerException(
      errno: $checkedConvert(json, 'errno', (v) => v as int),
      title: $checkedConvert(json, 'title', (v) => v as String),
      detail: $checkedConvert(json, 'detail', (v) => v as String),
    );
    return val;
  });
}

Map<String, dynamic> _$ServerExceptionToJson(ServerException instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('errno', instance.errno);
  writeNotNull('title', instance.title);
  writeNotNull('detail', instance.detail);
  return val;
}

ServerAuthorizationException _$ServerAuthorizationExceptionFromJson(
    Map<String, dynamic> json) {
  return $checkedNew('ServerAuthorizationException', json, () {
    final val = ServerAuthorizationException(
      errno: $checkedConvert(json, 'errno', (v) => v as int),
      title: $checkedConvert(json, 'title', (v) => v as String),
      authDetail: $checkedConvert(
          json,
          'detail',
          (v) => v == null
              ? null
              : AuthorizationExceptionDetails.fromJson(
                  v as Map<String, dynamic>)),
    );
    return val;
  }, fieldKeyMap: const {'authDetail': 'detail'});
}

Map<String, dynamic> _$ServerAuthorizationExceptionToJson(
    ServerAuthorizationException instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('errno', instance.errno);
  writeNotNull('title', instance.title);
  writeNotNull('detail', instance.authDetail?.toJson());
  return val;
}

AuthorizationExceptionDetails _$AuthorizationExceptionDetailsFromJson(
    Map<String, dynamic> json) {
  return $checkedNew('AuthorizationExceptionDetails', json, () {
    final val = AuthorizationExceptionDetails(
      email: $checkedConvert(json, 'email', (v) => v as String),
      password: $checkedConvert(json, 'password', (v) => v as String),
      general: $checkedConvert(json, 'general', (v) => v as String),
      name: $checkedConvert(json, 'name', (v) => v as String),
      surname: $checkedConvert(json, 'surname', (v) => v as String),
      patronymic: $checkedConvert(json, 'patronymic', (v) => v as String),
      birthday: $checkedConvert(json, 'birthday', (v) => v as String),
    );
    return val;
  });
}

Map<String, dynamic> _$AuthorizationExceptionDetailsToJson(
    AuthorizationExceptionDetails instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('email', instance.email);
  writeNotNull('password', instance.password);
  writeNotNull('general', instance.general);
  writeNotNull('name', instance.name);
  writeNotNull('surname', instance.surname);
  writeNotNull('patronymic', instance.patronymic);
  writeNotNull('birthday', instance.birthday);
  return val;
}
