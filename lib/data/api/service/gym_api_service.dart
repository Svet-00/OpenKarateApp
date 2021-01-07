//@dart=2.9
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/network/remote_api.dart';
import '../../../domain/entities/gym.dart';

part 'gym_api_service.g.dart';

@RestApi(baseUrl: '$api_v1_0_endpoint/gyms')
abstract class GymApiService {
  /// Fetches gyms
  ///
  /// Throws [DioError] for all error codes
  @GET('/')
  Future<List<Gym>> getGyms();

  @POST('/{id}/remove-from-favorites')
  Future<void> removeFromFavorites(@Path('id') String id);

  @POST('/{id}/add-to-favorites')
  Future<void> addToFavorites(@Path('id') String id);

  factory GymApiService(Dio dio, {String baseUrl}) = _GymApiService;
}
