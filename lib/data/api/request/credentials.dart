import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'credentials.g.dart';

@JsonSerializable()
class Credentials extends Equatable {
  final String fingerprint;
  final String email;
  final String password;

  Credentials({
    this.fingerprint,
    this.email,
    this.password,
  });

  factory Credentials.fromJson(Map<String, dynamic> json) =>
      _$CredentialsFromJson(json);

  Map<String, dynamic> toJson() => _$CredentialsToJson(this);

  @override
  List<Object> get props => [fingerprint, email, password];

  @override
  bool get stringify => true;
}
