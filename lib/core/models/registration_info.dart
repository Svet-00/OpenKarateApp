import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'registration_info.g.dart';

@JsonSerializable()
class RegistrationInfo extends Equatable {
  final String fingerprint;
  final String email;
  final String password;
  final String name;
  final String surname;
  final String patronymic;
  final DateTime birthday;
  final int level;
  const RegistrationInfo({
    this.fingerprint,
    this.email = '',
    this.password = '',
    this.name = '',
    this.surname = '',
    this.patronymic = '',
    this.birthday,
    this.level = 0,
  })  : assert(email != null),
        assert(password != null),
        assert(name != null),
        assert(surname != null),
        assert(patronymic != null),
        assert(level != null);

  factory RegistrationInfo.fromJson(Map<String, dynamic> json) =>
      _$RegistrationInfoFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationInfoToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      fingerprint,
      email,
      password,
      name,
      surname,
      patronymic,
      birthday,
      level,
    ];
  }

  RegistrationInfo copyWith({
    String fingerprint,
    String email,
    String password,
    String name,
    String surname,
    String patronymic,
    DateTime birthday,
    int level,
  }) {
    return RegistrationInfo(
      fingerprint: fingerprint ?? this.fingerprint,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      patronymic: patronymic ?? this.patronymic,
      birthday: birthday ?? this.birthday,
      level: level ?? this.level,
    );
  }
}
