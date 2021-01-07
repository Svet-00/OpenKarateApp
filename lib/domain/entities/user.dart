import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../core/utils/nullable.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  // required
  final String id;
  final String email;
  final String name;
  final String surname;
  final UserAvatar avatar;
  final int level;
  final DateTime birthday;

  // not null
  @JsonKey(defaultValue: [])
  final List<String> groups;
  @JsonKey(name: 'admin', defaultValue: false)
  final bool isAdmin;
  @JsonKey(name: 'trainer')
  final bool isTrainer;
  @JsonKey(name: 'events', defaultValue: [])
  final List<int> eventIds;

  // nullable
  @JsonKey(ignore: true)
  final String password;
  final String patronymic;
  final String shortDescription;
  final String longDescription;
  final double weight;

  const User({
    @required this.id,
    @required this.email,
    @required this.name,
    @required this.surname,
    @required this.avatar,
    @required this.level,
    @required this.birthday,
    this.groups = const [],
    this.isAdmin = false,
    this.isTrainer = false,
    this.eventIds = const [],
    this.password,
    this.patronymic,
    this.shortDescription,
    this.longDescription,
    this.weight,
  })  : assert(id != null),
        assert(email != null),
        assert(name != null),
        assert(surname != null),
        assert(avatar != null),
        assert(level != null),
        assert(birthday != null);

  int get age {
    if (birthday == null) return null;

    final now = DateTime.now();
    final bd = birthday;
    var year = now.year - bd.year;
    if (now.month < bd.month || (now.month == bd.month && now.day < bd.day)) {
      year -= 1;
    }
    return year;
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String id,
    String email,
    String name,
    String surname,
    UserAvatar avatar,
    int level,
    DateTime birthday,
    List<String> groups,
    bool isAdmin,
    bool isTrainer,
    List<String> eventIds,
    Nullable<String> password,
    Nullable<String> patronymic,
    Nullable<String> shortDescription,
    Nullable<String> longDescription,
    Nullable<double> weight,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      avatar: avatar ?? this.avatar,
      level: level ?? this.level,
      birthday: birthday ?? this.birthday,
      groups: groups ?? this.groups,
      isAdmin: isAdmin ?? this.isAdmin,
      isTrainer: isTrainer ?? this.isTrainer,
      eventIds: eventIds ?? this.eventIds,
      password: password == null ? this.password : password.value,
      patronymic: patronymic == null ? this.patronymic : patronymic.value,
      shortDescription: shortDescription == null
          ? this.shortDescription
          : shortDescription.value,
      longDescription: longDescription == null
          ? this.longDescription
          : longDescription.value,
      weight: weight == null ? this.weight : weight.value,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      email,
      name,
      surname,
      avatar,
      level,
      groups,
      isAdmin,
      isTrainer,
      eventIds,
      password,
      patronymic,
      shortDescription,
      longDescription,
      birthday,
      weight,
    ];
  }
}

@JsonSerializable()
class UserAvatar extends Equatable {
  final String square;
  final String wide;

  const UserAvatar({
    @required this.square,
    @required this.wide,
  });

  factory UserAvatar.fromJson(Map<String, dynamic> json) =>
      _$UserAvatarFromJson(json);

  Map<String, dynamic> toJson() => _$UserAvatarToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [square, wide];
}
