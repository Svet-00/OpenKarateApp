import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_credentials.g.dart';

@JsonSerializable()
class RefreshTokenCredentials extends Equatable {
  final String fingerprint;
  final String refreshToken;
  RefreshTokenCredentials({
    this.fingerprint,
    this.refreshToken,
  });

  factory RefreshTokenCredentials.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenCredentialsFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenCredentialsToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [fingerprint, refreshToken];
}
