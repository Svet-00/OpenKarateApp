import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:strings/strings.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../presentation/colors.dart';
import '../../bloc/events_cubit.dart';

class EventCalendar extends StatefulWidget {
  const EventCalendar({
    Key key,
  }) : super(key: key);

  @override
  _EventCalendarState createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  CalendarController _calendarController;
  EventsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _cubit = BlocProvider.of<EventsCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(
      builder: (context, state) {
        return TableCalendar(
          calendarController: _calendarController,
          builders: CalendarBuilders(
            markersBuilder: _buildMarkers,
            todayDayBuilder: _buildToday,
            selectedDayBuilder: _buildSelectedDay,
          ),
          locale: 'ru_Ru',
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            headerMargin: EdgeInsets.all(0),
            headerPadding: EdgeInsets.all(0),
            centerHeaderTitle: true,
            titleTextBuilder: (date, locale) {
              return capitalize(DateFormat.yMMMM().format(date));
            },
          ),
          events: state.events.map,
          onVisibleDaysChanged: (_, _1, format) {
            _cubit.maybeResetSelectedDate(format);
          },
          onDaySelected: (day, events, holidays) {
            assert(day.isUtc);
            _cubit.selectDate(day);
          },
          rowHeight: 45,
          calendarStyle: CalendarStyle(
            renderDaysOfWeek: true,
            renderSelectedFirst: true,
          ),
          startingDayOfWeek: StartingDayOfWeek.monday,
          availableCalendarFormats: const {
            CalendarFormat.month: 'Месяц',
            CalendarFormat.week: 'Неделя',
          },
          availableGestures: AvailableGestures.all,
          initialCalendarFormat: CalendarFormat.week,
          formatAnimation: FormatAnimation.slide,
        );
      },
    );
  }

  List<Widget> _buildMarkers(context, date, events, holidays) {
    final now = DateTime.now();
    final today =
        date.year == now.year && date.month == now.month && date.day == now.day;
    return [
      SizedBox(
        width: 16,
        height: 16,
        child: Text('${events.length}').fontSize(10).center(),
      )
          .decorated(
            borderRadius: BorderRadius.circular(8),
            color: today
                ? Colors.red.shade300
                : Theme.of(context).colorScheme.primaryVariant.lighten(50),
          )
          .padding(right: 3, bottom: 3)
          .alignment(Alignment.bottomRight),
    ];
  }

  Widget _buildToday(BuildContext context, DateTime date, List events) {
    return SizedBox(
      width: 33,
      height: 33,
      child: Text(date.day.toString()).center(),
    )
        .decorated(
          color: Theme.of(context).colorScheme.primary.withOpacity(.3),
          borderRadius: BorderRadius.circular(50),
        )
        .center();
  }

  Widget _buildSelectedDay(BuildContext context, DateTime date, List events) {
    return SizedBox(
      width: 33,
      height: 33,
      child: Text(date.day.toString())
          .fontSize(17)
          .textColor(Colors.white)
          .center(),
    )
        .decorated(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(50),
        )
        .center();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }
}
