import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'link.g.dart';

@JsonSerializable()
class Link extends Equatable {
  final String url;
  final String title;
  const Link({
    @required this.url,
    this.title,
  }) : assert(url != null);

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);

  Map<String, dynamic> toJson() => _$LinkToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [url, title];
}
