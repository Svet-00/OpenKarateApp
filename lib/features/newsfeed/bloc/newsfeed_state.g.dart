// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newsfeed_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsfeedState _$NewsfeedStateFromJson(Map<String, dynamic> json) {
  return $checkedNew('NewsfeedState', json, () {
    final val = NewsfeedState(
      posts: $checkedConvert(
          json,
          'posts',
          (v) => (v as List)
              ?.map((e) =>
                  e == null ? null : Post.fromJson(e as Map<String, dynamic>))
              ?.toList()),
      hasReachedMax: $checkedConvert(json, 'has_reached_max', (v) => v as bool),
      pageStatus: $checkedConvert(
          json,
          'page_status',
          (v) => _$enumDecodeNullable(_$NewsfeedStatusEnumMap, v,
              unknownValue: NewsfeedStatus.initial)),
    );
    return val;
  }, fieldKeyMap: const {
    'hasReachedMax': 'has_reached_max',
    'pageStatus': 'page_status'
  });
}

Map<String, dynamic> _$NewsfeedStateToJson(NewsfeedState instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('posts', instance.posts?.map((e) => e?.toJson())?.toList());
  writeNotNull('has_reached_max', instance.hasReachedMax);
  writeNotNull('page_status', _$NewsfeedStatusEnumMap[instance.pageStatus]);
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

const _$NewsfeedStatusEnumMap = {
  NewsfeedStatus.initial: 'initial',
  NewsfeedStatus.success: 'success',
  NewsfeedStatus.error: 'error',
};
