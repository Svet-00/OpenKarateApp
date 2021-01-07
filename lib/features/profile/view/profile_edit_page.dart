import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation/forms/user_profile_form.dart';
import '../../../presentation/widgets/app_scaffold.dart';
import '../../../presentation/widgets/authorization_builder.dart';
import '../../authorization/cubit/authorization_cubit.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text('Личный кабинет'),
      ),
      body: AuthorizationBuilder(
        authorized: (context, user) => Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: UserProfileForm(
            user: user,
            actionName: 'Сохранить',
            onSubmit: (user) {
              BlocProvider.of<AuthorizationCubit>(context)
                  .updateUserProfile(user);
            },
          ),
        ),
      ),
      isModalPage: true,
    );
  }
}
