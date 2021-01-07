import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token_pair.g.dart';

@JsonSerializable(nullable: false)
class TokenPair extends Equatable {
  final String accessToken;
  final String refreshToken;
  const TokenPair({
    @required this.accessToken,
    @required this.refreshToken,
  })  : assert(accessToken != null),
        assert(refreshToken != null);

  factory TokenPair.fromJson(Map<String, dynamic> json) =>
      _$TokenPairFromJson(json);
  Map<String, dynamic> toJson() => _$TokenPairToJson(this);

  @override
  List<Object> get props => [accessToken, refreshToken];

  @override
  bool get stringify => false;
}
