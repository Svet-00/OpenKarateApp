import 'package:flutter/material.dart';

import '../../../presentation/widgets/app_scaffold.dart';
import 'login_view.dart';

class LoginPage extends StatelessWidget {
  LoginPage();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: LoginView(),
    );
  }
  //
}
