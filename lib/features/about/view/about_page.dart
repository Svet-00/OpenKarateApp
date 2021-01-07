import 'package:about/about.dart' as about;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

import '../../../presentation/widgets/app_scaffold.dart';
import '../../../presentation/widgets/flushbar_helpers.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: about.AboutPage(
        scaffoldBuilder: (context, title, child) => AppScaffold(
          appBar: AppBar(title: title),
          body: child,
        ),
        title: Text('О приложении'),
        applicationIcon: SizedBox.fromSize(
          size: MediaQuery.of(context).size / 5,
          child: Image.asset('assets/images/icon/icon.png'),
        ),
        // TODO: fix copyright
        applicationLegalese: 'Copyright © , {{ year }}',
        // TODO: fix app description
        applicationDescription: const Text(
          'Displays an About dialog, which describes the application.\n'
          'Displays an About dialog, which describes the application.\n'
          'Displays an About dialog, which describes the application.\n'
          'Displays an About dialog, which describes the application.\n'
          'Displays an About dialog, which describes the application.\n'
          'Displays an About dialog, which describes the application.\n'
          'Displays an About dialog, which describes the application.\n'
          'Displays an About dialog, which describes the application.\n'
          'Displays an About dialog, which describes the application.\n',
        ),
        children: [
          about.MarkdownPageListTile(
            icon: Icon(
              Icons.change_history,
              color: Colors.black,
            ),
            title: const Text('История обновлений'),
            filename: 'assets/CHANGELOG.md',
          ),
          ListTile(
            leading: Icon(
              Icons.favorite_outline,
              color: Colors.redAccent,
            ),
            title: Text('Использованные библиотеки'),
            onTap: () => showLicensePage(
              context: context,
              applicationIcon: null,
              applicationLegalese: null,
              applicationVersion: null,
              applicationName: '',
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.bug_report,
              color: Colors.green.shade800,
            ),
            // TODO: Сообщить об ошибке в приложении
            title: Text('Отправить логи'),
            onTap: () async {
              try {
                final dir = await getTemporaryDirectory();
                final files = await dir.list();
                final selection =
                    await files.where((e) => e.path.endsWith('.log')).toList();
                final paths = selection.map((e) => e.path).toList();
                await Share.shareFiles(paths);
              } on Exception catch (e) {
                await FlushbarHelpers.createError(
                  message: 'Ошибка при сборе логов: $e',
                ).show(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
