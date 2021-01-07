import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../core/utils/nullable.dart';
import '../../domain/entities/user.dart';
import '../../domain/validation/user_validator.dart';
import '../../features/localizations/app_localizations.dart';
import 'fields/styled_text_form_field.dart';
import 'fields/user_level_select_form_field.dart';

class UserProfileForm extends StatefulWidget {
  final User user;
  final String actionName;
  final void Function(User user) onSubmit;
  UserProfileForm({
    Key key,
    @required this.user,
    @required this.actionName,
    @required this.onSubmit,
  }) : super(key: key);

  @override
  _UserProfileFormState createState() => _UserProfileFormState();
}

class _UserProfileFormState extends State<UserProfileForm> {
  static final _formKey = GlobalKey<FormState>();

  User _user;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    final validator = UserValidator();
    return Container(
      child: Form(
        child: ListView(
          children: [
            StyledTextFormField(
              placeholder: AppLocalizations.email(),
              initialValue: widget.user.email,
              validator: validator.email,
              onSaved: (v) => setState(
                () => _user = _user.copyWith(email: v),
              ),
            ),
            StyledTextFormField(
              placeholder: AppLocalizations.surname(),
              initialValue: widget.user.surname,
              validator: validator.surname,
              onSaved: (v) => setState(
                () => _user = _user.copyWith(email: v),
              ),
            ),
            StyledTextFormField(
              placeholder: AppLocalizations.name(),
              initialValue: widget.user.name,
              validator: validator.name,
              onSaved: (v) => setState(
                () => _user = _user.copyWith(name: v),
              ),
            ),
            StyledTextFormField(
              placeholder: AppLocalizations.patronymic(),
              initialValue: widget.user.patronymic,
              validator: validator.patronymic,
              onSaved: (v) => setState(
                () => _user = _user.copyWith(patronymic: Nullable(v)),
              ),
            ),
            _user.isTrainer
                ? StyledTextFormField(
                    placeholder: 'Короткое описание',
                    initialValue: widget.user.shortDescription,
                    onSaved: (v) => setState(
                      () =>
                          _user = _user.copyWith(shortDescription: Nullable(v)),
                    ),
                  )
                : Container(),
            _user.isTrainer
                ? StyledTextFormField(
                    placeholder: 'Полное описание',
                    initialValue: widget.user.longDescription,
                    onSaved: (v) => setState(
                      () =>
                          _user = _user.copyWith(longDescription: Nullable(v)),
                    ),
                  )
                : Container(),
            Row(
              children: [
                Text('Уровень мастерства').expanded(),
                UserLevelSelectFormField(
                  onChanged: (v) {
                    setState(() {
                      _user = _user.copyWith(level: v.numericValue);
                    });
                  },
                )
              ],
            ),
            StyledTextFormField(
              placeholder: AppLocalizations.password(),
              onSaved: (v) => setState(
                () => _user = _user.copyWith(password: Nullable(v)),
              ),
            ),
            SizedBox(
              child: RaisedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    widget.onSubmit(_user);
                  }
                },
                child: Text(widget.actionName),
              ),
            ).padding(vertical: 16.0).center(),
          ],
        ),
      ).padding(horizontal: 16),
    );
  }
}
