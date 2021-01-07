import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_topic.g.dart';

@JsonSerializable()
class NotificationTopic extends Equatable {
  final String stringRepresentation;
  final String description;
  @JsonKey(defaultValue: false)
  final bool subscribed;
  @JsonKey(defaultValue: false)
  final bool important;

  const NotificationTopic({
    @required this.stringRepresentation,
    @required this.description,
    this.subscribed = false,
    this.important = false,
  })  : assert(stringRepresentation != null),
        assert(description != null),
        assert(subscribed != null),
        assert(important != null);

  NotificationTopic copyWith({
    String stringRepresentation,
    String description,
    bool subscribed,
    bool important,
  }) {
    return NotificationTopic(
      stringRepresentation: stringRepresentation ?? this.stringRepresentation,
      description: description ?? this.description,
      subscribed: subscribed ?? this.subscribed,
      important: important ?? this.important,
    );
  }

  factory NotificationTopic.fromJson(Map<String, dynamic> json) =>
      _$NotificationTopicFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationTopicToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props =>
      [stringRepresentation, description, subscribed, important];
}
