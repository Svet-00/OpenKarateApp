// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return $checkedNew('Post', json, () {
    final val = Post(
      text: $checkedConvert(json, 'text', (v) => v as String),
      createdAt: $checkedConvert(json, 'created_at',
          (v) => v == null ? null : DateTime.parse(v as String)),
      photos: $checkedConvert(
              json,
              'photos',
              (v) => (v as List)
                  ?.map((e) => e == null
                      ? null
                      : Photo.fromJson(e as Map<String, dynamic>))
                  ?.toList()) ??
          [],
      documents: $checkedConvert(
              json,
              'documents',
              (v) => (v as List)
                  ?.map((e) => e == null
                      ? null
                      : Document.fromJson(e as Map<String, dynamic>))
                  ?.toList()) ??
          [],
    );
    return val;
  }, fieldKeyMap: const {'createdAt': 'created_at'});
}

Map<String, dynamic> _$PostToJson(Post instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('text', instance.text);
  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  writeNotNull('photos', instance.photos?.map((e) => e?.toJson())?.toList());
  writeNotNull(
      'documents', instance.documents?.map((e) => e?.toJson())?.toList());
  return val;
}
