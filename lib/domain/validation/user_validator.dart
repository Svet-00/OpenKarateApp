import '../../features/localizations/app_localizations.dart';
import 'validator.dart';

class UserValidator extends Validator {
  UserValidator() : super(false);
  UserValidator.optional() : super(true);

  String email(String value) {
    return validate(() {
      notEmpty(value, AppLocalizations.email().toLowerCase());
      isValidEmail(value ?? '');
    });
  }

  String password(value) {
    return validate(() {
      notEmpty(value, AppLocalizations.password().toLowerCase());
      minLength(6, value, AppLocalizations.password());
    });
  }

  String name(value) {
    return validate(() {
      notEmpty(value, AppLocalizations.name().toLowerCase());
    });
  }

  String patronymic(value) {
    return validate(() {});
  }

  String surname(value) {
    return validate(() {
      notEmpty(value, AppLocalizations.surnameAccusative().toLowerCase());
    });
  }

  String birthday(value) {
    return validate(() {
      notEmpty(value, AppLocalizations.birthdayAccusative());
    });
  }
}
