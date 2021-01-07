//@dart=2.9
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/network/remote_api.dart';
import '../../../domain/entities/user.dart';

part 'user_api_service.g.dart';

@RestApi(baseUrl: '$api_v1_0_endpoint')
abstract class UserApiService {
  @GET('/trainers')
  Future<List<User>> getTrainers();

  @FormUrlEncoded()
  @POST('/user/{id}')
  Future<User> updateUserProfile(@Path('id') String id, @Body() User user);

  factory UserApiService(Dio dio, {String baseUrl}) = _UserApiService;
}
