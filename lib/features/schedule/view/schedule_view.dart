import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedantic/pedantic.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../domain/entities/gym.dart';
import '../../../domain/entities/schedule.dart';
import '../../../domain/page_status.dart';
import '../../../presentation/widgets/app_circular_progress_indicator.dart';
import '../../../presentation/widgets/app_scaffold.dart';
import '../../../presentation/widgets/flushbar_helpers.dart';
import '../../../presentation/widgets/fullscreen_message.dart';
import '../bloc/schedule_cubit.dart';
import 'widgets/schedule_card.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scheduleCubit = BlocProvider.of<ScheduleCubit>(context);

    return AppScaffold(
      appBar: AppBar(
        title: Text('Расписание'),
      ),
      body: Builder(
        builder: (ctx) => RefreshIndicator(
          onRefresh: scheduleCubit.update,
          child: BlocConsumer<ScheduleCubit, ScheduleState>(
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
                  return _buildBody(state.gyms, state.schedules);
                case PageStatus.initial:
                default:
                  return AppCircularProgressIndicator().center();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody(List<Gym> gyms, List<Schedule> schedules) {
    if (gyms.isEmpty || schedules.isEmpty) {
      return FullscreenMessage('Список расписаний пуст').center();
    }
    return SizedBox.expand(
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: _buildCards(gyms, schedules),
      ),
    );
  }

  List<ScheduleCard> _buildCards(List<Gym> gyms, List<Schedule> schedules) {
    final result = <ScheduleCard>[];
    gyms.forEach(
      (gym) => result.add(
        ScheduleCard(
          gym: gym,
          schedules: schedules.where((e) => e.gymId == gym.id).toList(),
        ),
      ),
    );
    return result;
  }
}
