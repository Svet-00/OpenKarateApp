import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/post.dart';
import '../../domain/repositories/news_repository.dart';
import '../api/service/news_api_service.dart';
import 'repository.dart';

class NewsRepositoryImpl extends Repository implements NewsRepository {
  final NewsApiService apiService;

  NewsRepositoryImpl({
    @required this.apiService,
  });

  @override
  Future<List<Post>> getPosts({
    @required int start,
    @required int count,
  }) async {
    try {
      return await apiService.getPosts(start, count);
    } on DioError catch (e) {
      throw convertError(e);
    }
  }
}
