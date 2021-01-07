//@dart=2.9
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/network/remote_api.dart';
import '../../../domain/entities/schedule.dart';

part 'schedule_api_service.g.dart';

@RestApi(baseUrl: '$api_v1_0_endpoint')
abstract class ScheduleApiService {
  /// Fetches schedules for specified gym id
  ///
  /// Throws [DioError] for all error codes
  @GET('/gyms/{id}/schedules')
  Future<List<Schedule>> getSchedulesForGym(@Path('id') String id);

  @GET('/schedules')
  Future<List<Schedule>> getSchedules();

  factory ScheduleApiService(Dio dio, {String baseUrl}) = _ScheduleApiService;
}
