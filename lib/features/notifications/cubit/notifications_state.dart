import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/notification_topic.dart';

part 'notifications_state.g.dart';

@JsonSerializable()
class NotificationsState extends Equatable {
  final List<NotificationTopic> topics;
  const NotificationsState({
    @required this.topics,
  }) : assert(topics != null);

  NotificationsState copyWith({
    List<NotificationTopic> topics,
  }) {
    return NotificationsState(
      topics: topics ?? this.topics,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [topics];
}
