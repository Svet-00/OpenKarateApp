import 'package:intl/intl.dart';

class AppLocalizations {
  static String eventCanceled() => Intl.message(
        'Отменено',
        desc: 'Состояние события',
      );

  static String appTitle() => 'OpenKarateApp';
  static String email() => Intl.message('Адрес электронной почты');
  static String dan() => Intl.message('дан');
  static String kyu() => Intl.message('кю');
  static String birthday() => Intl.message(
        'Дата рождения',
        desc: 'Используется в формах, относящихся к пользователям',
      );
  static String birthdayAccusative() => Intl.message(
        'дату рождения',
        desc: 'Используется, если пользователь не ввёл свою дату рождения',
      );
  static String fio() => Intl.message('ФИО');
  static String add() => Intl.message('Добавить');
  static String children() => Intl.message('Дети');
  static String surname() => Intl.message('Фамилия');
  static String surnameAccusative() => Intl.message('фамилию');
  static String name() => Intl.message('Имя');
  static String patronymic() => Intl.message('Отчество');
  static String training() => Intl.message('Тренировка');
  static String trainings() => Intl.message('Тренировки');
  static String event() => Intl.message('Мероприятие');
  static String events() => Intl.message('Мероприятия');
  static String login() => Intl.message('Вход');
  static String password() => Intl.message('Пароль');
  static String forgotPassword() => Intl.message('Забыли пароль?');
}
