// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'security_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _SecurityApiService implements SecurityApiService {
  _SecurityApiService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://192.168.0.163/api/v1.0';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<Passport> login(credentials) async {
    ArgumentError.checkNotNull(credentials, 'credentials');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(credentials?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('/auth',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = Passport.fromJson(_result.data);
    return value;
  }

  @override
  Future<Passport> register(registrationInfo) async {
    ArgumentError.checkNotNull(registrationInfo, 'registrationInfo');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(registrationInfo?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('/register',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = Passport.fromJson(_result.data);
    return value;
  }

  @override
  Future<TokenPair> refreshTokens(credentials) async {
    ArgumentError.checkNotNull(credentials, 'credentials');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(credentials?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        '/auth/refresh-tokens',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = TokenPair.fromJson(_result.data);
    return value;
  }
}
