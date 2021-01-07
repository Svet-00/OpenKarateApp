import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logger/logger.dart';

import '../../../core/exceptions/exceptions.dart';
import '../../../core/injection_container.dart';
import '../../../core/models/registration_info.dart';
import '../../../core/utils/nullable.dart';
import '../../../data/api/request/credentials.dart';
import '../../../data/api/request/refresh_token_credentials.dart';
import '../../../domain/entities/passport.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../localizations/error_localizations.dart';
import '../../settings/cubit/settings_cubit.dart';
import 'authorization_state.dart';

export 'authorization_state.dart';

class AuthorizationCubit extends HydratedCubit<AuthorizationState> {
  final SettingsCubit settingsCubit;
  final UserRepository userRepository;
  final logger = sl<Logger>();

  final _dio;
  String _accessToken;
  Interceptor _accessKeyInterceptor;
  StreamSubscription _accessTokenInterceptorSubscription;

  AuthorizationCubit(
    this.settingsCubit,
    this.userRepository,
    Dio dio,
  )   : _dio = dio,
        super(const AuthorizationState()) {
    if (state.pageStatus.isLoading) {
      emit(state.copyWith(pageStatus: AuthorizationPageStatus.showingForm));
    }
    // TODO: refactor and test this trash (working at the time of writing)
    // TODO: decompose and decouple whatever possible
    _accessKeyInterceptor = InterceptorsWrapper(
      onRequest: _addAuthenticationHeaders,
    );
    _accessTokenInterceptorSubscription = listen(_initRequestInterceptor);

    _initRequestInterceptor(state);
  }

  Future<void> login(String email, String password) async {
    emit(
      state.copyWith(
        pageStatus: AuthorizationPageStatus.loading,
      ),
    );
    try {
      final passport = await userRepository.login(
        Credentials(
          fingerprint: settingsCubit.state.fingerprint,
          email: email,
          password: password,
        ),
      );
      sl<Logger>().i(passport);
      await _authorize(passport);
    } on Exception catch (e) {
      _handleException(e);
    }
  }

  Future<void> logout() async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: 'refresh_token');
    _accessToken = null;
    emit(const AuthorizationState());
  }

  Future<void> register(RegistrationInfo registrationInfo) async {
    emit(
      state.copyWith(
        pageStatus: AuthorizationPageStatus.loading,
        registrationInfo: registrationInfo,
      ),
    );
    try {
      final ri = registrationInfo.copyWith(
        fingerprint: settingsCubit.state.fingerprint,
      );
      final passport = await userRepository.register(ri);
      sl<Logger>().i(passport);
      await _authorize(passport);
    } on Exception catch (e) {
      _handleException(e);
    }
  }

  Future<void> updateUserProfile(User user) async {
    final initialUser = state.user;
    if (state.status.isGuest || initialUser == null) {
      throw StateError('Cant update profile info in guest mode.');
    }

    emit(state.copyWith(user: Nullable.notNull(user)));
    try {
      await userRepository.updateUserProfile(user);
    } on Exception catch (e) {
      _handleException(e, state.copyWith(user: Nullable.notNull(initialUser)));
    }
  }

  void dismissError() {
    emit(state.copyWith(
      generalError: Nullable.forceNull(),
      pageStatus: AuthorizationPageStatus.showingForm,
    ));
  }

  void updateRegistrationInfo(RegistrationInfo registrationInfo) {
    emit(
      state.copyWith(
        registrationInfo: registrationInfo,
      ),
    );
  }

  void _handleException(Exception exception, [AuthorizationState state]) {
    state ??= this.state;
    if (exception is ServerAuthorizationException) {
      emit(state.copyWith(authError: Nullable.notNull(exception)));
    } else if (exception is ServerException) {
      emit(
        state.copyWith(
          generalError: Nullable.notNull(
            ErrorLocalizations.checkNetworkConnection(),
          ),
        ),
      );
    } else {
      logger.e(exception);
    }
  }

  void _initRequestInterceptor(AuthorizationState state) {
    if (state.status.isAuthorized) {
      if (_dio.interceptors.contains(_accessKeyInterceptor) == false) {
        _dio.interceptors.add(_accessKeyInterceptor);
        final logger = sl<Logger>();
        logger.i('Dio accessToken interceptor added');
      }
    } else if (state.status.isGuest) {
      final removed = _dio.interceptors.remove(_accessKeyInterceptor);
      if (removed) {
        sl<Logger>().i('Dio accessToken interceptor removed');
      }
    }
  }

  Future<void> _authorize(Passport passport) async {
    final storage = FlutterSecureStorage();
    await storage.write(
      key: 'refresh_token',
      value: passport.tokens.refreshToken,
    );
    _accessToken = passport.tokens.accessToken;

    emit(AuthorizationState(pageStatus: AuthorizationPageStatus.success));
    await Future.delayed(Duration(seconds: 1));
    emit(AuthorizationState(
      user: passport.user,
    ));
  }

  Future<RequestOptions> _addAuthenticationHeaders(
      RequestOptions options) async {
    if (_accessToken == null || JwtDecoder.isExpired(_accessToken)) {
      _dio.lock();
      final storage = FlutterSecureStorage();
      final refreshToken = await storage.read(key: 'refresh_token');
      if (refreshToken == null || JwtDecoder.isExpired(refreshToken)) {
        emit(
          state.copyWith(
            generalError: Nullable.notNull(
              'Срок сессии истёк, необходимо заново войти в личный кабинет.',
            ),
            user: Nullable.forceNull(),
          ),
        );
        _dio.unlock();
        return null;
      }
      final newTokens = await userRepository.refreshTokens(
        RefreshTokenCredentials(
          fingerprint: settingsCubit.state.fingerprint,
          refreshToken: refreshToken,
        ),
      );
      _accessToken = newTokens.accessToken;
      await storage.write(
        key: 'refresh_token',
        value: newTokens.refreshToken,
      );
      // yes, this is code duplication
      // yes, I don't know if it's necessary
      // yes, I've read dio.unlock() docs and didn't get it
      options.headers['Authorization'] = _accessToken;
      _dio.unlock();
      return options;
    }
    options.headers['Authorization'] = _accessToken;
    return options;
  }

  @override
  AuthorizationState fromJson(Map<String, dynamic> json) =>
      AuthorizationState.fromJson(json);

  @override
  Map<String, dynamic> toJson(AuthorizationState state) => state.toJson();

  @override
  Future<void> close() {
    _accessTokenInterceptorSubscription.cancel();
    return super.close();
  }
}
