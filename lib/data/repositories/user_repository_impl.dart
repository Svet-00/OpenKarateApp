import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../core/models/registration_info.dart';
import '../../domain/entities/passport.dart';
import '../../domain/entities/token_pair.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../api/request/credentials.dart';
import '../api/request/refresh_token_credentials.dart';
import '../api/service/security_api_service.dart';
import '../api/service/user_api_service.dart';
import 'repository.dart';

class UserRepositoryImpl extends Repository implements UserRepository {
  final UserApiService apiService;
  final SecurityApiService securityApiService;

  UserRepositoryImpl({
    @required this.apiService,
    @required this.securityApiService,
  });

  @override
  Future<List<User>> fetchTrainers() async {
    try {
      return await apiService.getTrainers();
    } on DioError catch (e) {
      throw convertError(e);
    }
  }

  @override
  Future<Passport> login(Credentials credentials) async {
    try {
      return await securityApiService.login(credentials);
    } on DioError catch (e) {
      throw convertError(e);
    }
  }

  @override
  Future<TokenPair> refreshTokens(RefreshTokenCredentials credentials) async {
    try {
      return await securityApiService.refreshTokens(credentials);
    } on DioError catch (e) {
      throw convertError(e);
    }
  }

  @override
  Future<Passport> register(RegistrationInfo registrationInfo) async {
    try {
      return await securityApiService.register(registrationInfo);
    } on DioError catch (e) {
      throw convertError(e);
    }
  }

  @override
  Future<User> updateUserProfile(User user) async {
    try {
      return await apiService.updateUserProfile(user.id, user);
    } on DioError catch (e) {
      throw convertError(e);
    }
  }
}
