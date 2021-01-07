import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../core/utils/nullable.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/page_status.dart';

part 'users_state.g.dart';

@JsonSerializable()
class UsersState extends Equatable {
  @JsonKey(unknownEnumValue: PageStatus.initial)
  final PageStatus pageStatus;
  final List<User> users;
  final String errorMessage;
  const UsersState({
    this.pageStatus = PageStatus.initial,
    this.users = const [],
    this.errorMessage,
  })  : assert(pageStatus != null),
        assert(users != null);

  UsersState copyWith({
    PageStatus pageStatus,
    List<User> users,
    Nullable<String> errorMessage,
  }) {
    return UsersState(
      pageStatus: pageStatus ?? this.pageStatus,
      users: users ?? this.users,
      errorMessage:
          errorMessage == null ? this.errorMessage : errorMessage.value,
    );
  }

  factory UsersState.fromJson(Map<String, dynamic> json) =>
      _$UsersStateFromJson(json);

  Map<String, dynamic> toJson() => _$UsersStateToJson(this);

  @override
  List<Object> get props => [pageStatus, users, errorMessage];

  @override
  bool get stringify => true;
}
