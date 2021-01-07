import 'package:flutter/material.dart';

import '../../../presentation/widgets/app_scaffold.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text('Настройки'),
      ),
      body: Container(),
    );
  }
}
