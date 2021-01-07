import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logger/logger.dart';

import '../../../core/exceptions/exceptions.dart';
import '../../../core/injection_container.dart';
import '../../../domain/repositories/news_repository.dart';
import 'newsfeed_state.dart';

export './newsfeed_state.dart';

class NewsfeedCubit extends HydratedCubit<NewsfeedState> {
  final NewsRepository newsRepository;
  final logger = sl<Logger>();
  NewsfeedCubit({@required this.newsRepository})
      : super(const NewsfeedState()) {
    refresh(ignoreErrors: true);
  }

  Future<void> refresh({bool ignoreErrors = false}) async {
    emit(
      await _loadPosts(0, ignoreErrors: ignoreErrors),
    );
  }

  Future<void> fetchMorePosts() async {
    if (state.hasReachedMax) return;
    emit(
      await _loadPosts(state.posts.length),
    );
  }

  Future<NewsfeedState> _loadPosts(
    int start, {
    int count = 20,
    bool ignoreErrors = false,
  }) async {
    try {
      final posts = await newsRepository.getPosts(start: start, count: count);
      return NewsfeedState(
        pageStatus: NewsfeedStatus.success,
        posts: posts,
        hasReachedMax: posts.length < start + count,
      );
    } on ServerException catch (e, st) {
      logger.e((NewsfeedCubit).toString(), e, st);
      if (!ignoreErrors) {
        return state.copyWith(pageStatus: NewsfeedStatus.error);
      } else {
        return state;
      }
    } catch (e, st) {
      logger.wtf((NewsfeedCubit).toString(), e, st);
      if (!ignoreErrors) {
        return state.copyWith(pageStatus: NewsfeedStatus.error);
      } else {
        return state;
      }
    }
  }

  @override
  NewsfeedState fromJson(Map<String, dynamic> json) =>
      NewsfeedState.fromJson(json);

  @override
  Map<String, dynamic> toJson(NewsfeedState state) => state.toJson();
}
