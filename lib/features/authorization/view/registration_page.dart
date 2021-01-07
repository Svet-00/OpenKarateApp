import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../presentation/forms/user_registration_form.dart';
import '../../../presentation/widgets/app_circular_progress_indicator.dart';
import '../../../presentation/widgets/app_scaffold.dart';
import '../../../presentation/widgets/flushbar_helpers.dart';
import '../cubit/authorization_cubit.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage();

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  static final _formKey = GlobalKey<UserRegistrationFormState>();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isModalPage: true,
      appBar: AppBar(
        title: Text('Регистрация'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: TextButton(
                    onPressed: () {
                      _formKey.currentState?.reset();
                      ExtendedNavigator.root.pop();
                    },
                    child: Text('Очистить форму'),
                  ),
                ),
              ];
            },
          )
        ],
      ),
      body: Container(
        child: Padding(
          padding: MediaQuery.of(context).padding,
          child: BlocConsumer<AuthorizationCubit, AuthorizationState>(
            listener: (context, state) {
              if (state.generalError != null) {
                FlushbarHelpers.createError(
                  message: state.generalError,
                ).show(context);
                BlocProvider.of<AuthorizationCubit>(context).dismissError();
              }
            },
            builder: (context, state) {
              switch (state.pageStatus) {
                case AuthorizationPageStatus.loading:
                  return AppCircularProgressIndicator().center();
                case AuthorizationPageStatus.success:
                  return Icon(Icons.done, size: 60, color: Colors.green)
                      .center();
                case AuthorizationPageStatus.showingForm:
                default:
                  return UserRegistrationForm(
                    key: _formKey,
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
