//@dart=2.9
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/network/remote_api.dart';
import '../../../domain/entities/event.dart';

part 'event_api_service.g.dart';

@RestApi(baseUrl: '$api_v1_0_endpoint')
abstract class EventApiService {
  @GET('/events')
  Future<List<Event>> getEvents();

  @POST('/events/{id}/participate')
  Future<void> participateInEvent(@Path('id') String eventId);

  factory EventApiService(Dio dio, {String baseUrl}) = _EventApiService;
}
