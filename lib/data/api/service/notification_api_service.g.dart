// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'notification_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _NotificationApiService implements NotificationApiService {
  _NotificationApiService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://192.168.0.163/api/v1.0';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<NotificationTopic>> getNotificationTopics() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>(
        '/meta/app/notification-topics',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) =>
            NotificationTopic.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }
}
