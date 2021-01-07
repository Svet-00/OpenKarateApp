import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';
import '../../features/authorization/cubit/authorization_cubit.dart';

class AuthorizationBuilder extends StatelessWidget {
  final Widget Function(BuildContext) guest;
  final Widget Function(BuildContext, User) authorized;
  const AuthorizationBuilder({
    Key key,
    this.authorized,
    this.guest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorizationCubit, AuthorizationState>(
        builder: (context, state) {
      switch (state.status) {
        case AuthorizationStatus.authorized:
          return authorized?.call(context, state.user) ?? Container();
        case AuthorizationStatus.guest:
        default:
          return guest?.call(context) ?? Container();
      }
    });
  }
}
