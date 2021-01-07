// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map<String, dynamic> json) {
  return $checkedNew('Document', json, () {
    final val = Document(
      url: $checkedConvert(json, 'url', (v) => v as String),
      originalFilename:
          $checkedConvert(json, 'original_filename', (v) => v as String),
    );
    return val;
  }, fieldKeyMap: const {'originalFilename': 'original_filename'});
}

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'url': instance.url,
      'original_filename': instance.originalFilename,
    };
