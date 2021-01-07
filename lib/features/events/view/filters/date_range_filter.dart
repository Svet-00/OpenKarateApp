import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../presentation/widgets/app_scaffold.dart';
import '../../../../presentation/widgets/styled_raised_button.dart';
import '../../bloc/events_cubit.dart';

class EventDateRangeFilterPage extends StatelessWidget {
  final EventsCubit eventsCubit;
  final String title;
  final DateFormat dateFormat;
  const EventDateRangeFilterPage({
    Key key,
    @required this.eventsCubit,
    @required this.title,
    @required this.dateFormat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isModalPage: true,
      appBar: AppBar(title: Text(title)),
      body: BlocBuilder<EventsCubit, EventsState>(
        cubit: eventsCubit,
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('С'),
                    TextButton(
                      child: Text(
                        dateFormat.format(state.criteria.startDate),
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () => _selectDate(
                        context: context,
                        forStartDate: true,
                      ),
                    ),
                    Text('По'),
                    TextButton(
                      child: Text(
                        dateFormat.format(state.criteria.endDate),
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () => _selectDate(
                        context: context,
                        forStartDate: false,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: Container()),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: StyledRaisedButton(
                        title: 'Готово',
                        onPressed: ExtendedNavigator.root.pop,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  void _selectDate({
    @required BuildContext context,
    @required bool forStartDate,
  }) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(Duration(days: 365)),
      lastDate: now.add(Duration(days: 365)),
      selectableDayPredicate: (_) => true,
    );
    if (date != null) {
      if (forStartDate) {
        eventsCubit.updateCriteria(startDate: date);
      } else {
        eventsCubit.updateCriteria(endDate: date);
      }
    }
  }
}
