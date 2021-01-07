import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/router/router.gr.dart';
import '../../../domain/entities/user.dart';
import '../../../presentation/widgets/app_scaffold.dart';
import '../../../presentation/widgets/authorization_builder.dart';
import '../../authorization/cubit/authorization_cubit.dart';
import '../../authorization/view/login_page.dart';
import '../../localizations/action_localizations.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthorizationBuilder(
      guest: (context) => LoginPage(),
      authorized: (context, user) => AppScaffold(
        appBar: AppBar(
          title: Text('Личный кабинет'),
        ),
        body: Column(
          children: [
            ListView(
              children: [
                Text('${user.surname} ${user.name} ${user.patronymic}')
                    .fontSize(20)
                    .alignment(Alignment.topCenter),
                SizedBox(height: 16),
                ListTile(
                  title: Text(
                    'День рождения: ${user.birthday.day}.${user.birthday.month}.${user.birthday.year} (${user.age} лет)',
                  ),
                ),
                ..._buildTrainerDescriptionTiles(user),
                ..._buildDebugInfo(user),
              ],
            ).expanded(),
            ListTile(
              leading: Icon(Icons.cloud_download),
              title: Text('Скачать договор'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Выйти'),
              onTap: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Text(
                    'Вы действительно хотите выйти из личного кабинета?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: ExtendedNavigator.root.pop,
                      child: Text('Отмена'),
                    ),
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<AuthorizationCubit>(context).logout();
                        ExtendedNavigator.root.popUntilPath('/');
                      },
                      child: Text(ActionLocalizations.ok()),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTrainerDescriptionTiles(User user) {
    if (user.isTrainer == false) {
      return [];
    }
    final result = <Widget>[];
    result.add(
      ListTile(
        title: Text(
          user.shortDescription == null
              ? 'Короткое описание: Отсутствует'
              : 'Короткое описание:',
        ),
      ),
    );
    if (user.shortDescription != null) {
      result.add(
        ListTile(
          title: Text(user.shortDescription),
        ),
      );
    }
    result.add(
      ListTile(
        title: Text(
          user.longDescription == null
              ? 'Полное описание: Отсутствует'
              : 'Полное описание:',
        ),
      ),
    );
    if (user.longDescription != null) {
      result.add(
        ListTile(
          title: Text(user.longDescription),
        ),
      );
    }
    return result;
  }

  List<Widget> _buildDebugInfo(User user) {
    if (kDebugMode == false) {
      return [];
    }
    return [];
    [
      ListTile(
        title: Text('debug Тренер: ${user.isTrainer}'),
      ),
      ListTile(
        title: Text('debug Админ: ${user.isAdmin}'),
      ),
      ListTile(
        title: Text('debug Группы:\n' + user.groups.join('\n')),
      ),
      ListTile(
        title: Text('debug События:\n' + user.eventIds.join('\n')),
      ),
    ];
  }
}
