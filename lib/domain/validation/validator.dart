import 'package:flutter/foundation.dart';

import '../../core/exceptions/exceptions.dart';
import '../../features/localizations/error_localizations.dart';

abstract class Validator {
  final bool ignoreBlank;

  Validator(this.ignoreBlank);

  @protected
  String validate(void Function() constraintsChecker) {
    try {
      constraintsChecker();
    } on NotBlankException catch (e) {
      if (ignoreBlank) return null;
      return e.message;
    } on ValidationException catch (e) {
      return e.message;
    }
    return null;
  }

  @protected
  void notEmpty(String value, String fieldName) {
    if (value?.isEmpty ?? true) {
      throw ValidationException(
        message: ErrorLocalizations.fieldShouldNotBeEmpty(fieldName),
      );
    }
  }

  @protected
  void minLength(int length, String value, String fieldName) {
    if (value.length < length) {
      throw ValidationException(
        message: ErrorLocalizations.inputTooShort(fieldName, length),
      );
    }
  }

  @protected
  void isValidEmail(String value) {
    if (value.contains('@') == false) {
      throw ValidationException(
        message: ErrorLocalizations.emailShouldContainAtSign(),
      );
    }
    var re = RegExp(
      r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()'
      r'\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0'
      r'-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.'
      r'[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+'
      r'[a-zA-Z]{2,}))$',
    );
    if (re.stringMatch(value) != value) {
      throw ValidationException(
        message: ErrorLocalizations.invalidEmail(),
      );
    }
  }
}
