import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo.g.dart';

@JsonSerializable()
class Photo extends Equatable {
  final String filename;
  final int width;
  final int height;
  final String mimeType;
  final String url;
  final String bucket;
  const Photo({
    @required this.filename,
    @required this.width,
    @required this.height,
    @required this.mimeType,
    @required this.url,
    @required this.bucket,
  })  : assert(filename != null),
        assert(width != null),
        assert(height != null),
        assert(mimeType != null),
        assert(url != null),
        assert(bucket != null);

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);

  Photo copyWith({
    String filename,
    int width,
    int height,
    String mimeType,
    String url,
    String bucket,
  }) {
    return Photo(
      filename: filename ?? this.filename,
      width: width ?? this.width,
      height: height ?? this.height,
      mimeType: mimeType ?? this.mimeType,
      url: url ?? this.url,
      bucket: bucket ?? this.bucket,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      filename,
      width,
      height,
      mimeType,
      url,
      bucket,
    ];
  }
}
