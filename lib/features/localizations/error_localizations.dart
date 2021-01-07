import 'package:intl/intl.dart';

class ErrorLocalizations {
  ErrorLocalizations._();

  static String unknownError() => Intl.message('Неизвестная ошибка');

// TODO красивое сообщение
  static String sessionOutdated() => Intl.message(
        'Мы вас ждали! Пожалуйста, войдите в личный кабинет.',
      );

  static String invalidCredentials() => Intl.message(
        'Не удаётся войти.\n'
        'Пожалуйста, проверьте правильность написания логина и пароля.',
      );

  static String needToLogIn(String action) => Intl.message(
        'Чтобы $action нужно войти в личный кабинет',
        name: 'ErrorLocalizations_needToLogIn',
        args: [action],
      );

  static String fieldShouldNotBeEmpty(String fieldName) => Intl.message(
        'Пожалуйста, введите $fieldName',
        name: 'ErrorLocalizations_fieldShouldNotBeEmpty',
        args: [fieldName],
      );

  static String emailShouldContainAtSign() => Intl.message(
        'Адрес электронной почты должен содержать один символ \'@\'',
      );

  static String invalidEmail() => Intl.message(
        'Адрес электоронной почты содержит ошибку',
      );

  static String failedToLoadFromNetwork(String subject) => Intl.message(
        'Не удалось загрузить $subject',
        name: 'ErrorLocalizations_failedToLoadFromNetwork',
        args: [subject],
      );

  static String unsupportedUrl(String url) => Intl.message(
        'Ссылка $url не поддерживается.',
        name: 'ErrorLocalizations_unsupportedUrl',
        args: [url],
      );

  static String checkNetworkConnection() => Intl.message(
        'Не удаётся подключиться к сайту. '
        'Пожалуйста, проверьте ваше подключение к интернету.',
      );

  static String inputTooShort(String fieldName, int length) => Intl.message(
        '$fieldName не может быть короче $length символов',
        name: 'ErrorLocalizations_fieldTooShort',
        args: [fieldName, length],
      );
}
