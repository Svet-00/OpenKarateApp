import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'server_exceptions.g.dart';

/// Exceptions that can be (de)serialized directly from server response
@JsonSerializable()
class ServerException extends Equatable implements Exception {
  final int errno;
  final String title;
  final String detail;

  factory ServerException.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('runtimeType') || json['runtimeType'] == 'default') {
      return _$ServerExceptionFromJson(json);
    } else if (json['runtimeType'] == 'authorization') {
      return ServerAuthorizationException.fromJson(json);
    } else {
      return ServerException.unknownType(json['runtimeType']);
    }
  }

  const ServerException({this.errno, this.title, this.detail});

  factory ServerException.unknownType(String type) {
    return ServerException(
      errno: 0,
      title: 'От сервера получена неизвестная ошибка',
      detail: 'runtimeType был $type',
    );
  }

  @override
  List<Object> get props => [errno, title, detail];

  @override
  bool get stringify => true;
}

@JsonSerializable()
class ServerAuthorizationException extends ServerException {
  @JsonKey(name: 'detail')
  final AuthorizationExceptionDetails authDetail;
  const ServerAuthorizationException({
    int errno,
    String title,
    this.authDetail,
  }) : super(errno: errno, title: title);

  factory ServerAuthorizationException.fromJson(Map<String, dynamic> json) =>
      _$ServerAuthorizationExceptionFromJson(json);

  Map<String, dynamic> toJson() => _$ServerAuthorizationExceptionToJson(this);

  ServerAuthorizationException copyWith({
    int errno,
    String title,
    AuthorizationExceptionDetails authDetail,
  }) {
    return ServerAuthorizationException(
      errno: errno ?? this.errno,
      title: title ?? this.title,
      authDetail: authDetail ?? this.authDetail,
    );
  }

  @override
  String toString() => 'ServerAuthorizationException(authDetail: $authDetail)';
}

@JsonSerializable()
class AuthorizationExceptionDetails extends Equatable {
  final String email;
  final String password;
  final String general;
  final String name;
  final String surname;
  final String patronymic;
  final String birthday;
  AuthorizationExceptionDetails({
    this.email,
    this.password,
    this.general,
    this.name,
    this.surname,
    this.patronymic,
    this.birthday,
  });

  factory AuthorizationExceptionDetails.fromJson(Map<String, dynamic> json) =>
      _$AuthorizationExceptionDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorizationExceptionDetailsToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      email,
      password,
      general,
      name,
      surname,
      patronymic,
      birthday,
    ];
  }

  AuthorizationExceptionDetails copyWith({
    String email,
    String password,
    String general,
    String name,
    String surname,
    String patronymic,
    String birthday,
  }) {
    return AuthorizationExceptionDetails(
      email: email ?? this.email,
      password: password ?? this.password,
      general: general ?? this.general,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      patronymic: patronymic ?? this.patronymic,
      birthday: birthday ?? this.birthday,
    );
  }
}
