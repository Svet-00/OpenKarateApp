import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

import 'photo.dart';

import 'document.dart';

part 'post.g.dart';

@JsonSerializable()
class Post extends Equatable {
  final String text;
  final DateTime createdAt;
  @JsonKey(defaultValue: [])
  final List<Photo> photos;
  @JsonKey(defaultValue: [])
  final List<Document> documents;
  Post({
    @required this.text,
    @required this.createdAt,
    this.photos = const [],
    this.documents = const [],
  })  : assert(text != null || photos.isNotEmpty || documents.isNotEmpty),
        assert(createdAt != null);

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  static final jsonFactory = _$PostFromJson;

  Map<String, dynamic> toJson() => _$PostToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      text,
      createdAt,
      photos,
      documents,
    ];
  }

  Post copyWith({
    String text,
    DateTime createdAt,
    List<Photo> photos,
    List<Document> documents,
  }) {
    return Post(
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      photos: photos ?? this.photos,
      documents: documents ?? this.documents,
    );
  }
}
