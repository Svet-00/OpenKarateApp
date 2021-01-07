import 'package:intl/intl.dart';

class ActionLocalizations {
  static String buildARoute() => Intl.message(
        'Построить маршрут',
        desc: 'Действие по которому открывается '
            'построенный в навигаторе маршрут.',
      );
  static String close() => Intl.message('Закрыть');
  static String save() => Intl.message('Сохранить');
  static String cancel() =>
      Intl.message('Отмена', desc: 'Отказ от выполнения действия');
  static String signUp() => Intl.message('Зарегистрироваться');
  static String signIn() => Intl.message('Войти');
  static String share() => Intl.message('Поделиться');
  static String notNow() => Intl.message('Не сейчас');
  static String search() => Intl.message('Поиск');
  static String ok() => Intl.message('Ок');
}
