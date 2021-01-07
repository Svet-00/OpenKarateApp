import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/post.dart';

part 'newsfeed_state.g.dart';

enum NewsfeedStatus { initial, success, error }

extension NewsfeedStatusX on NewsfeedStatus {
  bool get isInitial => this == NewsfeedStatus.initial;
  bool get isSuccess => this == NewsfeedStatus.success;
  bool get isError => this == NewsfeedStatus.error;
}

@JsonSerializable()
class NewsfeedState {
  final List<Post> posts;
  final bool hasReachedMax;
  @JsonKey(unknownEnumValue: NewsfeedStatus.initial)
  final NewsfeedStatus pageStatus;

  const NewsfeedState({
    this.posts = const [],
    this.hasReachedMax = false,
    this.pageStatus = NewsfeedStatus.initial,
  })  : assert(posts != null),
        assert(hasReachedMax != null),
        assert(pageStatus != null);

  factory NewsfeedState.fromJson(Map<String, dynamic> json) =>
      _$NewsfeedStateFromJson(json);

  Map<String, dynamic> toJson() => _$NewsfeedStateToJson(this);

  NewsfeedState copyWith({
    List<Post> posts,
    bool hasReachedMax,
    NewsfeedStatus pageStatus,
  }) {
    return NewsfeedState(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }

  @override
  String toString() =>
      'NewsfeedState(posts: $posts, hasReachedMax: $hasReachedMax, status: $pageStatus)';
}
