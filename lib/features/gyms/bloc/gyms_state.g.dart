// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gyms_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GymsState _$GymsStateFromJson(Map<String, dynamic> json) {
  return $checkedNew('GymsState', json, () {
    final val = GymsState(
      pageStatus: $checkedConvert(
          json,
          'page_status',
          (v) => _$enumDecodeNullable(_$PageStatusEnumMap, v,
              unknownValue: PageStatus.initial)),
      gyms: $checkedConvert(
          json,
          'gyms',
          (v) => (v as List)
              ?.map((e) =>
                  e == null ? null : Gym.fromJson(e as Map<String, dynamic>))
              ?.toList()),
      errorMessage: $checkedConvert(json, 'error_message', (v) => v as String),
    );
    return val;
  }, fieldKeyMap: const {
    'pageStatus': 'page_status',
    'errorMessage': 'error_message'
  });
}

Map<String, dynamic> _$GymsStateToJson(GymsState instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page_status', _$PageStatusEnumMap[instance.pageStatus]);
  writeNotNull('gyms', instance.gyms?.map((e) => e?.toJson())?.toList());
  writeNotNull('error_message', instance.errorMessage);
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

const _$PageStatusEnumMap = {
  PageStatus.initial: 'initial',
  PageStatus.loading: 'loading',
  PageStatus.success: 'success',
};
