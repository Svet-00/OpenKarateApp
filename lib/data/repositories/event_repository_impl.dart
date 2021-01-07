import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/event.dart';
import '../../domain/repositories/event_repository.dart';
import '../api/service/event_api_service.dart';
import 'repository.dart';

class EventRepositoryImpl extends Repository implements EventRepository {
  final EventApiService apiService;

  EventRepositoryImpl({
    @required this.apiService,
  });

  @override
  Future<List<Event>> fetchEvents() async {
    try {
      return await apiService.getEvents();
    } on DioError catch (e) {
      throw convertError(e);
    }
  }

  @override
  Future<void> participateInEvent(Event event) async {
    try {
      return await apiService.participateInEvent(event.id);
    } on DioError catch (e) {
      throw convertError(e);
    }
  }
}
