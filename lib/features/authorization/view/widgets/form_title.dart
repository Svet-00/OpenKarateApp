import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../localizations/app_localizations.dart';

class LoginFormTitle extends StatelessWidget {
  const LoginFormTitle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        AppLocalizations.login(),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline4,
      ).padding(horizontal: 80, vertical: 5).decorated(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.shade500,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
    );
  }
}
