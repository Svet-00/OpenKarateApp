import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/gym.dart';
import '../../domain/entities/schedule.dart';
import '../../domain/repositories/schedule_repository.dart';
import '../api/service/schedule_api_service.dart';
import 'repository.dart';

class ScheduleRepositoryImpl extends Repository implements ScheduleRepository {
  final ScheduleApiService apiService;

  ScheduleRepositoryImpl({
    @required this.apiService,
  });

  @override
  Future<List<Schedule>> fetchForGym(
    Gym gym,
  ) async {
    try {
      return await apiService.getSchedulesForGym(gym.id);
    } on DioError catch (e) {
      throw convertError(e);
    }
  }

  @override
  Future<List<Schedule>> fetchAll() async {
    try {
      return await apiService.getSchedules();
    } on DioError catch (e) {
      throw convertError(e);
    }
  }
}
