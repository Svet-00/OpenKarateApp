// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Photo _$PhotoFromJson(Map<String, dynamic> json) {
  return $checkedNew('Photo', json, () {
    final val = Photo(
      filename: $checkedConvert(json, 'filename', (v) => v as String),
      width: $checkedConvert(json, 'width', (v) => v as int),
      height: $checkedConvert(json, 'height', (v) => v as int),
      mimeType: $checkedConvert(json, 'mime_type', (v) => v as String),
      url: $checkedConvert(json, 'url', (v) => v as String),
      bucket: $checkedConvert(json, 'bucket', (v) => v as String),
    );
    return val;
  }, fieldKeyMap: const {'mimeType': 'mime_type'});
}

Map<String, dynamic> _$PhotoToJson(Photo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('filename', instance.filename);
  writeNotNull('width', instance.width);
  writeNotNull('height', instance.height);
  writeNotNull('mime_type', instance.mimeType);
  writeNotNull('url', instance.url);
  writeNotNull('bucket', instance.bucket);
  return val;
}
