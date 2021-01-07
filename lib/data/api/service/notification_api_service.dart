//@dart=2.9
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:openkarateapp/domain/entities/notification_topic.dart';

import '../../../core/network/remote_api.dart';

part 'notification_api_service.g.dart';

@RestApi(baseUrl: '$api_v1_0_endpoint')
abstract class NotificationApiService {
  @GET('/meta/app/notification-topics')
  Future<List<NotificationTopic>> getNotificationTopics();

  factory NotificationApiService(Dio dio, {String baseUrl}) =
      _NotificationApiService;
}
