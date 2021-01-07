import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'document.g.dart';

@JsonSerializable(nullable: false)
class Document extends Equatable {
  final String url;
  final String originalFilename;

  const Document({
    @required this.url,
    @required this.originalFilename,
  })  : assert(url != null),
        assert(originalFilename != null);

  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [url, originalFilename];
}
