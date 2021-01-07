// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'news_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _NewsApiService implements NewsApiService {
  _NewsApiService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://192.168.0.163/api/v1.0';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<Post>> getPosts(start, count) async {
    ArgumentError.checkNotNull(start, 'start');
    ArgumentError.checkNotNull(count, 'count');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'start': start, r'count': count};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/news',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Post.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }
}
