import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../domain/entities/event.dart';
import '../../../presentation/widgets/app_circular_progress_indicator.dart';
import '../../../presentation/widgets/fullscreen_message.dart';
import '../bloc/events_cubit.dart';
import '../bloc/events_holder.dart';
import 'widgets/event_tile.dart';

class EventsListView extends StatelessWidget {
  EventsListView({Key key}) : super(key: key);
  final dateFormat = DateFormat('dd.M.y');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<EventsCubit>(context);
        switch (state.pageStatus) {
          case EventsStatus.success:
            return _buildList(state.events, cubit);
          case EventsStatus.filtered:
            return _buildList(state.filtered, cubit);
          case EventsStatus.initial:
          default:
            return AppCircularProgressIndicator().center();
        }
      },
    );
  }

  Widget _buildList(EventsHolder events, EventsCubit cubit) {
    if (events.set.isEmpty) {
      return FullscreenMessage('Список событий пуст');
    }

    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _buildEventsColumnForSingleDate(
          events.forDate(events.dates[index]),
          events.dates[index],
        );
      },
      itemCount: events.dates.length,
    );
  }

  Widget _buildEventsColumnForSingleDate(
    Iterable<Event> events,
    DateTime date,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Text('${dateFormat.format(date)}').fontSize(18),
            Divider(
              indent: 8,
              endIndent: 16,
            ).expanded()
          ],
        ).padding(left: 16, vertical: 10),
        ...events.map((e) => EventTile(event: e)),
      ],
    );
  }
}
