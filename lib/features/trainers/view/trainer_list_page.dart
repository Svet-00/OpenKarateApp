import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedantic/pedantic.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/injection_container.dart';
import '../../../core/router/router.gr.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/page_status.dart';
import '../../../presentation/widgets/app_circular_progress_indicator.dart';
import '../../../presentation/widgets/app_scaffold.dart';
import '../../../presentation/widgets/flushbar_helpers.dart';
import '../../../presentation/widgets/fullscreen_message.dart';
import '../bloc/users_cubit.dart';

class TrainerListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: Text('Тренеры')),
      body: BlocProvider<UsersCubit>(
        create: (context) => sl<UsersCubit>(),
        child: _TrainerListPageContent(),
      ),
    );
  }
}

class _TrainerListPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersCubit, UsersState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          unawaited(
            FlushbarHelpers.createError(message: state.errorMessage)
                .show(context),
          );
        }
      },
      builder: (context, state) {
        switch (state.pageStatus) {
          case PageStatus.success:
            return _buildBody(context, state.users);
          case PageStatus.initial:
          default:
            return AppCircularProgressIndicator().center();
        }
      },
    );
  }

  Widget _buildBody(BuildContext context, List<User> trainers) {
    if (trainers.isEmpty) return FullscreenMessage('Список тренеров пуст');
    return ListView(
      children: ListTile.divideTiles(
        context: context,
        tiles: trainers.map(
          (trainer) => ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                trainer.avatar.square,
              ),
              radius: 26,
            ),
            title: Text(
                '${trainer.surname} ${trainer.name} ${trainer.patronymic}'),
            subtitle: Text(
              trainer.shortDescription ?? '',
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            isThreeLine: true,
            onTap: () => ExtendedNavigator.root.push(
              Routes.trainerDetailPage,
              arguments: TrainerDetailPageArguments(trainer: trainer),
            ),
          ),
        ),
      ).toList(),
    );
  }
}
