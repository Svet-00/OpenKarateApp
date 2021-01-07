import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation/widgets/app_scaffold.dart';
import '../../authorization/cubit/authorization_cubit.dart';

class DevOptionsPage extends StatelessWidget {
  const DevOptionsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text('dev page'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Выйти'),
            onTap: () {
              BlocProvider.of<AuthorizationCubit>(context).logout();
            },
          ),
        ],
      ),
    );
  }
}
