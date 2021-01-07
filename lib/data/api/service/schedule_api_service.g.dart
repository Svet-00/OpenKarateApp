// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'schedule_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ScheduleApiService implements ScheduleApiService {
  _ScheduleApiService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://192.168.0.163/api/v1.0';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<Schedule>> getSchedulesForGym(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/gyms/$id/schedules',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Schedule.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<Schedule>> getSchedules() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/schedules',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Schedule.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }
}
