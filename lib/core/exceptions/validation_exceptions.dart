import 'dart:convert';

import 'package:equatable/equatable.dart';

class ValidationException extends Equatable {
  final String message;
  ValidationException({
    this.message,
  });

  ValidationException copyWith({
    String message,
  }) {
    return ValidationException(
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
    };
  }

  factory ValidationException.fromMap(Map<String, dynamic> map) {
    if (map == null) return ValidationException();

    return ValidationException(
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ValidationException.fromJson(String source) =>
      ValidationException.fromMap(json.decode(source));

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;
}

class NotBlankException extends ValidationException {}
