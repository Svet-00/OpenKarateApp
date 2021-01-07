import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/exceptions/exceptions.dart';
import '../../../core/injection_container.dart';
import '../../../core/models/registration_info.dart';
import '../../../core/router/router.gr.dart';
import '../../../domain/validation/user_validator.dart';
import '../../../presentation/colors.dart';
import '../../../presentation/forms/fields/styled_text_form_field.dart';
import '../../../presentation/widgets/app_circular_progress_indicator.dart';
import '../../../presentation/widgets/flushbar_helpers.dart';
import '../../../presentation/widgets/styled_raised_button.dart';
import '../../localizations/action_localizations.dart';
import '../../localizations/app_localizations.dart';
import '../cubit/authorization_cubit.dart';
import 'widgets/form_container.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  static final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FormContainer(
      BlocConsumer<AuthorizationCubit, AuthorizationState>(
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
              return AppCircularProgressIndicator().center().height(300);
            case AuthorizationPageStatus.success:
              return Icon(Icons.done, size: 60, color: BrandColors.success)
                  .center()
                  .height(300);
            case AuthorizationPageStatus.showingForm:
            default:
              _emailController.text = state.registrationInfo.email;
              _passwordController.text = state.registrationInfo.password;
              return _buildBody(
                state.authError,
                state.registrationInfo,
              );
          }
        },
      ),
    )
        .backgroundBlur(1)
        .backgroundColor(Colors.white12)
        .backgroundImage(DecorationImage(
          image: AssetImage('assets/images/login_bg.jpg'),
          fit: BoxFit.cover,
        ));
  }

  Widget _buildBody([
    ServerAuthorizationException error,
    RegistrationInfo registrationInfo,
  ]) {
    final cubit = BlocProvider.of<AuthorizationCubit>(context);
    final validator = UserValidator();

    final dense = MediaQuery.of(context).size.width <= 320;

    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StyledTextFormField(
              controller: _emailController,
              errorText: error?.authDetail?.email,
              placeholder: AppLocalizations.email(),
              validator: validator.email,
            ),
            StyledTextFormField(
              controller: _passwordController,
              obscureToggle: true,
              obscureText: true,
              errorText: error?.authDetail?.password,
              placeholder: AppLocalizations.password(),
              validator: validator.password,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StyledRaisedButton(
                  title: ActionLocalizations.signUp(),
                  onPressed: () {
                    cubit.updateRegistrationInfo(
                      registrationInfo.copyWith(
                        email: _emailController.text,
                        password: _passwordController.text,
                      ),
                    );
                    ExtendedNavigator.root.push(
                      Routes.registrationPage,
                    );
                  },
                ).expanded(flex: 7),
                SizedBox(width: dense ? 5 : 10),
                StyledRaisedButton(
                  title: ActionLocalizations.signIn(),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      cubit.login(
                        _emailController.text,
                        _passwordController.text,
                      );
                    }
                  },
                ).expanded(flex: 3),
              ],
            ).padding(top: dense ? 3 : 10),
            _buildHelpLink().padding(vertical: 10)
          ],
        ).padding(horizontal: dense ? 10 : 16),
      ),
    );
  }

  Widget _buildHelpLink() {
    return GestureDetector(
      onTap: () {
        // TODO: implement forgot password
        sl<Logger>().w('help requested');
      },
      child: Text(
        AppLocalizations.forgotPassword(),
        style: Theme.of(context).textTheme.button.apply(
              color: Colors.blue[900],
              decoration: TextDecoration.underline,
            ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
