//@dart=2.9
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/network/remote_api.dart';
import '../../../domain/entities/post.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: '$api_v1_0_endpoint')
abstract class NewsApiService {
  @GET('/news')
  Future<List<Post>> getPosts(
    @Query('start') int start,
    @Query('count') int count,
  );

  factory NewsApiService(Dio dio, {String baseUrl}) = _NewsApiService;
}
