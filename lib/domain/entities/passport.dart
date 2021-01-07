import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'token_pair.dart';
import 'user.dart';

part 'passport.g.dart';

@JsonSerializable(nullable: false)
class Passport extends Equatable {
  final TokenPair tokens;
  final User user;
  const Passport({
    @required this.tokens,
    @required this.user,
  })  : assert(tokens != null),
        assert(user != null);

  factory Passport.fromJson(Map<String, dynamic> json) =>
      _$PassportFromJson(json);

  Map<String, dynamic> toJson() => _$PassportToJson(this);

  @override
  bool get stringify => false;

  @override
  List<Object> get props => [tokens, user];
}
