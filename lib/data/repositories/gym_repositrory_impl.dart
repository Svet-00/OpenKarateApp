import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/gym.dart';
import '../../domain/repositories/gym_repository.dart';
import '../api/service/gym_api_service.dart';
import 'repository.dart';

class GymRepositoryImpl extends Repository implements GymRepository {
  final GymApiService apiService;

  GymRepositoryImpl({
    @required this.apiService,
  });

  @override
  Future<List<Gym>> fetchAll() async {
    try {
      return await apiService.getGyms();
    } on DioError catch (e) {
      throw convertError(e);
    }
  }

  @override
  Future<void> addToFavorites(String id) async {
    try {
      return await apiService.addToFavorites(id);
    } on DioError catch (e) {
      throw convertError(e);
    }
  }

  @override
  Future<void> removeFromFavorites(String id) async {
    try {
      return await apiService.removeFromFavorites(id);
    } on DioError catch (e) {
      throw convertError(e);
    }
  }
}
