import 'package:flutter/foundation.dart';

import '../entities/post.dart';

abstract class NewsRepository {
  Future<List<Post>> getPosts({
    @required int start,
    @required int count,
  });
}
