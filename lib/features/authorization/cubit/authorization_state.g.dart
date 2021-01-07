// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorization_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorizationState _$AuthorizationStateFromJson(Map<String, dynamic> json) {
  return $checkedNew('AuthorizationState', json, () {
    final val = AuthorizationState(
      pageStatus: $checkedConvert(
          json,
          'page_status',
          (v) => _$enumDecodeNullable(_$AuthorizationPageStatusEnumMap, v,
              unknownValue: AuthorizationPageStatus.showingForm)),
      registrationInfo: $checkedConvert(
          json,
          'registration_info',
          (v) => v == null
              ? null
              : RegistrationInfo.fromJson(v as Map<String, dynamic>)),
      user: $checkedConvert(json, 'user',
          (v) => v == null ? null : User.fromJson(v as Map<String, dynamic>)),
      generalError: $checkedConvert(json, 'general_error', (v) => v as String),
      authError: $checkedConvert(
          json,
          'auth_error',
          (v) => v == null
              ? null
              : ServerAuthorizationException.fromJson(
                  v as Map<String, dynamic>)),
    );
    return val;
  }, fieldKeyMap: const {
    'pageStatus': 'page_status',
    'registrationInfo': 'registration_info',
    'generalError': 'general_error',
    'authError': 'auth_error'
  });
}

Map<String, dynamic> _$AuthorizationStateToJson(AuthorizationState instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'page_status', _$AuthorizationPageStatusEnumMap[instance.pageStatus]);
  writeNotNull('registration_info', instance.registrationInfo?.toJson());
  writeNotNull('user', instance.user?.toJson());
  writeNotNull('auth_error', instance.authError?.toJson());
  writeNotNull('general_error', instance.generalError);
  return val;
}

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$AuthorizationPageStatusEnumMap = {
  AuthorizationPageStatus.showingForm: 'showingForm',
  AuthorizationPageStatus.loading: 'loading',
  AuthorizationPageStatus.success: 'success',
};
