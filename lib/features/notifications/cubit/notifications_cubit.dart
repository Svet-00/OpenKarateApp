import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:pedantic/pedantic.dart';
import '../../../data/api/service/notification_api_service.dart';
import '../../../domain/entities/notification_topic.dart';

import '../../../core/injection_container.dart';
import '../../authorization/cubit/authorization_cubit.dart';
import 'notifications_state.dart';

export 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final logger = sl<Logger>();
  final AuthorizationCubit authorizationCubit;
  final NotificationApiService notificationApiService;

  NotificationsCubit({
    @required this.authorizationCubit,
    @required this.notificationApiService,
  }) : super(const NotificationsState(topics: [])) {
    unawaited(init());
  }

  Future<void> init() async {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        logger.d('onMessage: $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        logger.d('onLaunch: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        logger.d('onResume: $message');
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
        sound: true,
        badge: true,
        alert: true,
        provisional: true,
      ),
    );

    _firebaseMessaging.onIosSettingsRegistered.listen(
      (IosNotificationSettings settings) {
        logger.i('Settings registered: $settings');
      },
    );

    final token = await _firebaseMessaging.getToken();
    logger.i('Push Messaging token: $token');

    authorizationCubit.listen(
      (state) {
        if (state.status.isAuthorized) {
          state.user.groups.forEach((group) {
            _firebaseMessaging.subscribeToTopic(group);
            if (state.user.age != null) {
              _firebaseMessaging.subscribeToTopic('age${state.user.age}');
            }
          });
        }
      },
    );

    await _updateTopics();
  }

  void unsubscribeFromTopic(NotificationTopic topic) {
    if (!topic.subscribed) {
      logger.w(
        'Calling ${(unsubscribeFromTopic).toString()} '
        'on topic with subscribed flag set to false',
      );
    } else {
      logger.d(
        'NotificationsCubit: unsubscribed '
        'from topic ${topic.stringRepresentation}',
      );
      _firebaseMessaging.unsubscribeFromTopic(topic.stringRepresentation);
      final newList = List<NotificationTopic>.from(state.topics);
      final index = state.topics.indexOf(topic);
      if (index != -1) {
        newList[index] = topic.copyWith(subscribed: false);
      } else {
        newList.add(topic.copyWith(subscribed: false));
      }
      emit(state.copyWith(topics: newList));
    }
  }

  void subscribeToTopic(NotificationTopic topic) {
    if (topic.subscribed) {
      logger.w('Calling ${(subscribeToTopic).toString()} '
          'on topic with subscribed flag set to true');
    } else {
      logger.d(
        'NotificationsCubit: subscribed to '
        'topic ${topic.stringRepresentation}',
      );
      _firebaseMessaging.subscribeToTopic(topic.stringRepresentation);
      final newList = List<NotificationTopic>.from(state.topics);
      final index = state.topics.indexOf(topic);
      if (index != -1) {
        newList[index] = topic.copyWith(subscribed: true);
      } else {
        newList.add(topic.copyWith(subscribed: true));
      }
      emit(state.copyWith(topics: newList));
    }
  }

  Future<void> _updateTopics() async {
    try {
      final newTopicList = <NotificationTopic>[];
      final remoteTopics = await notificationApiService.getNotificationTopics();
      remoteTopics.forEach((topic) {
        final localTopic = state.topics.singleWhere(
          (e) => e.stringRepresentation == topic.stringRepresentation,
          orElse: () => null,
        );
        if (localTopic != null) {
          if (localTopic.description != topic.description ||
              localTopic.important != topic.important) {
            newTopicList.add(topic.copyWith(subscribed: localTopic.subscribed));
          } else {
            newTopicList.add(localTopic);
          }
        } else {
          // subscribe to new topics by default
          subscribeToTopic(topic);
          newTopicList.add(topic.copyWith(subscribed: true));
        }
      });

      emit(NotificationsState(topics: newTopicList));
    } on DioError {
      // TODO: use connectivity
      Future.delayed(Duration(minutes: 3), () => _updateTopics());
    }
  }
}
