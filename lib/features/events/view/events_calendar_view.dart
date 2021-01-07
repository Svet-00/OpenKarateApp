import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/utils/datetime_x.dart';
import '../../../presentation/widgets/app_circular_progress_indicator.dart';
import '../../../presentation/widgets/flushbar_helpers.dart';
import '../../../presentation/widgets/fullscreen_message.dart';
import '../bloc/events_cubit.dart';
import '../bloc/events_holder.dart';
import 'widgets/event_calendar.dart';
import 'widgets/event_tile.dart';

class EventsCalendarView extends StatefulWidget {
  @override
  _EventsCalendarViewState createState() => _EventsCalendarViewState();
}

class _EventsCalendarViewState extends State<EventsCalendarView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<EventsCubit>(context).selectDate(DateTime.now().toDate());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        EventCalendar(),
        Divider(),
        BlocConsumer<EventsCubit, EventsState>(
          listener: (ctx, state) async {
            if (state.errorMessage != null) {
              await FlushbarHelpers.createError(message: state.errorMessage)
                  .show(context);
              BlocProvider.of<EventsCubit>(context).dismissError();
            }
          },
          builder: (context, state) {
            switch (state.pageStatus) {
              case EventsStatus.success:
                return _displayEvents(state.events, state.selectedDate);
              case EventsStatus.filtered:
              case EventsStatus.initial:
              default:
                return AppCircularProgressIndicator().center();
            }
          },
        ).expanded(),
      ],
    );
  }

  Widget _displayEvents(EventsHolder events, DateTime selectedDate) {
    final activeEvents = events.forDate(selectedDate);
    if (activeEvents?.isEmpty ?? true) {
      return selectedDate == null
          ? FullscreenMessage('')
          : FullscreenMessage(
              'Для ' +
                  DateFormat('dd.M.y').format(selectedDate) +
                  ' событий нет',
            ).center();
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: activeEvents.length,
      itemBuilder: (context, index) {
        final event = activeEvents[index];
        return EventTile(
          key: ObjectKey(event),
          event: event,
        );
      },
    );
  }
}
