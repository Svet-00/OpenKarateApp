import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../core/models/registration_info.dart';
import '../../core/utils/user_level.dart';
import '../../domain/validation/user_validator.dart';
import '../../features/authorization/cubit/authorization_cubit.dart';
import '../../features/localizations/app_localizations.dart';
import '../widgets/styled_raised_button.dart';
import 'fields/date_form_field.dart';
import 'fields/styled_text_form_field.dart';
import 'fields/user_level_select_form_field.dart';

class UserRegistrationForm extends StatefulWidget {
  UserRegistrationForm({
    Key key,
  }) : super(key: key);

  @override
  UserRegistrationFormState createState() => UserRegistrationFormState();
}

class UserRegistrationFormState extends State<UserRegistrationForm> {
  static final _formKey = GlobalKey<FormState>();
  static final _birthdayKey = GlobalKey<DateFormFieldState>();
  static final _levelKey = GlobalKey<UserLevelSelectFormFieldState>();
  AuthorizationCubit authorizationCubit;

  //form data
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _patronymicController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  DateTime _birthday;
  UserLevel _level;

  UserRegistrationFormState();

  @override
  void initState() {
    super.initState();
    authorizationCubit = context.read<AuthorizationCubit>();
    final ri = authorizationCubit.state.registrationInfo;
    _nameController.text = ri.name;
    _surnameController.text = ri.surname;
    _patronymicController.text = ri.patronymic;
    _passwordController.text = ri.password;
    _emailController.text = ri.email;
    _birthday = ri.birthday;
    _level = ri.level == null ? UserLevel.na() : UserLevel(ri.level);

    _nameController.addListener(() {
      authorizationCubit.updateRegistrationInfo(
        authorizationCubit.state.registrationInfo
            .copyWith(name: _nameController.text),
      );
    });
    _surnameController.addListener(() {
      authorizationCubit.updateRegistrationInfo(
        authorizationCubit.state.registrationInfo
            .copyWith(surname: _surnameController.text),
      );
    });
    _patronymicController.addListener(() {
      authorizationCubit.updateRegistrationInfo(
        authorizationCubit.state.registrationInfo
            .copyWith(patronymic: _patronymicController.text),
      );
    });
    _passwordController.addListener(() {
      authorizationCubit.updateRegistrationInfo(
        authorizationCubit.state.registrationInfo
            .copyWith(password: _passwordController.text),
      );
    });
    _emailController.addListener(() {
      authorizationCubit.updateRegistrationInfo(
        authorizationCubit.state.registrationInfo
            .copyWith(email: _emailController.text),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final validator = UserValidator();

    return Form(
      key: _formKey,
      child: BlocBuilder<AuthorizationCubit, AuthorizationState>(
        buildWhen: (previous, current) =>
            previous.authError != current.authError &&
            current.pageStatus == AuthorizationPageStatus.showingForm,
        builder: (context, state) {
          if (!state.pageStatus.isShowingForm) return Container();
          return ListView(
            semanticChildCount: 13,
            cacheExtent: double.infinity,
            children: [
              // * email
              StyledTextFormField(
                controller: _emailController,
                errorText: state.authError?.authDetail?.email,
                placeholder: AppLocalizations.email(),
                validator: validator.email,
              ),
              // * password
              StyledTextFormField(
                controller: _passwordController,
                placeholder: AppLocalizations.password(),
                errorText: state.authError?.authDetail?.password,
                validator: validator.password,
                obscureText: true,
                obscureToggle: true,
              ),
              // * surname
              StyledTextFormField(
                placeholder: AppLocalizations.surname(),
                errorText: state.authError?.authDetail?.surname,
                validator: validator.surname,
              ),
              // * name
              StyledTextFormField(
                initialValue: state.registrationInfo.name,
                placeholder: AppLocalizations.name(),
                errorText: state.authError?.authDetail?.name,
                validator: validator.name,
              ),
              // * patronymic
              StyledTextFormField(
                initialValue: state.registrationInfo.patronymic,
                placeholder: AppLocalizations.patronymic(),
                errorText: state.authError?.authDetail?.patronymic,
                validator: validator.patronymic,
              ),
              // * birthday
              DateFormField(
                key: _birthdayKey,
                initialDate: _birthday,
                placeholder: AppLocalizations.birthday(),
                errorText: state.authError?.authDetail?.birthday,
                validator: validator.birthday,
                onSave: (value) {
                  setState(() {
                    if (value != null) {
                      _birthday = value;
                    }
                  });
                },
              ),
              // * user level
              Row(
                children: [
                  Text('Уровень мастерства').expanded(),
                  UserLevelSelectFormField(
                    key: _levelKey,
                    value: _level,
                    onChanged: (newValue) {
                      setState(() {
                        _level = newValue;
                      });
                    },
                  )
                ],
              ),
              Row(
                children: [
                  StyledRaisedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        authorizationCubit.register(
                          RegistrationInfo(
                            email: _emailController.text,
                            password: _passwordController.text,
                            name: _nameController.text,
                            surname: _surnameController.text,
                            patronymic: _patronymicController.text,
                            birthday: _birthday,
                            level: _level.numericValue,
                          ),
                        );
                      }
                    },
                    title: 'Зарегистрироваться',
                  ).expanded(flex: 3),
                ],
              ).padding(vertical: 16.0),
            ],
          );
        },
      ),
    ).padding(horizontal: 16);
  }

  void reset() {
    _nameController.text = '';
    _surnameController.text = '';
    _patronymicController.text = '';
    _passwordController.text = '';
    _emailController.text = '';
    _birthdayKey.currentState.reset();
    _levelKey.currentState.reset();
    _birthday = DateTime.now();
    _level = const UserLevel.na();
    authorizationCubit.updateRegistrationInfo(
      const RegistrationInfo(),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _patronymicController.dispose();
    _surnameController.dispose();
    _formKey.currentState.dispose();
    super.dispose();
  }
}
