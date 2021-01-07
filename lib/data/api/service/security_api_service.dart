//@dart=2.9
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:openkarateapp/core/models/registration_info.dart';

import '../../../core/network/remote_api.dart';
import '../../../domain/entities/passport.dart';
import '../../../domain/entities/token_pair.dart';
import '../request/credentials.dart';
import '../request/refresh_token_credentials.dart';

part 'security_api_service.g.dart';

@RestApi(baseUrl: '$api_v1_0_endpoint')
abstract class SecurityApiService {
  @FormUrlEncoded()
  @POST('/auth')
  Future<Passport> login(@Body() Credentials credentials);

  @FormUrlEncoded()
  @POST('/register')
  Future<Passport> register(@Body() RegistrationInfo registrationInfo);

  @FormUrlEncoded()
  @POST('/auth/refresh-tokens')
  Future<TokenPair> refreshTokens(@Body() RefreshTokenCredentials credentials);

  factory SecurityApiService(Dio dio, {String baseUrl}) = _SecurityApiService;
}
