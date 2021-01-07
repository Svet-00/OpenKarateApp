import 'package:flutter/material.dart';

import '../../../presentation/widgets/app_scaffold.dart';

class BugReportPage extends StatelessWidget {
  const BugReportPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppScaffold(
        isModalPage: true,
        appBar: AppBar(
          title: Text('Отчет об ошибке'),
        ),
        body: Container(),
      ),
    );
  }
}
