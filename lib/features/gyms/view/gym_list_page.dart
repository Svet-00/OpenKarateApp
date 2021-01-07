import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/injection_container.dart';
import '../../../core/router/router.gr.dart';
import '../../../domain/entities/gym.dart';
import '../../../domain/page_status.dart';
import '../../../presentation/widgets/app_circular_progress_indicator.dart';
import '../../../presentation/widgets/app_scaffold.dart';
import '../../../presentation/widgets/flushbar_helpers.dart';
import '../../../presentation/widgets/fullscreen_message.dart';
import '../bloc/gyms_cubit.dart';

class GymListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text('Залы'),
      ),
      body: BlocProvider<GymsCubit>(
        create: (context) => sl<GymsCubit>(),
        child: _GymListPageContent(),
      ),
    );
  }
}

class _GymListPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GymsCubit, GymsState>(
      listener: (context, state) async {
        if (state.errorMessage != null) {
          await FlushbarHelpers.createError(message: state.errorMessage)
              .show(context);
          BlocProvider.of<GymsCubit>(context).dismissError();
        }
      },
      builder: (context, state) {
        switch (state.pageStatus) {
          case PageStatus.success:
            if (state.gyms.isEmpty) {
              return FullscreenMessage('Список залов пуст');
            }
            return ListView(
              children: [
                ...ListTile.divideTiles(
                  context: context,
                  tiles: state.gyms.map(
                    (gym) => _buildGymTile(context, gym),
                  ),
                ).toList(),
                Divider(
                  height: 1,
                )
              ],
            );
          case PageStatus.initial:
          default:
            return AppCircularProgressIndicator().center();
        }
      },
    );
  }

  Widget _buildGymTile(BuildContext context, Gym gym) {
    return ListTile(
      title: Text(gym.title),
      subtitle: Text(gym.address),
      onTap: () => ExtendedNavigator.of(context).push(
        Routes.gymDetailsPage,
        arguments: GymDetailsPageArguments(gymId: gym.id),
      ),
    );
  }
}
