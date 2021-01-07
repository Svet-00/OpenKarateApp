import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/event.dart';
import '../../../../presentation/widgets/app_scaffold.dart';
import '../../../../presentation/widgets/styled_raised_button.dart';
import '../../bloc/events_cubit.dart';

class EventLevelFilterPage extends StatelessWidget {
  final String title;
  final EventsCubit eventsCubit;
  const EventLevelFilterPage({
    Key key,
    @required this.title,
    @required this.eventsCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isModalPage: true,
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocBuilder<EventsCubit, EventsState>(
        cubit: eventsCubit,
        builder: (context, state) {
          return Column(
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  ..._generateChoices(state.criteria.level, state.events.set),
                ],
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

  void _onValueChanged(String value) {
    {
      eventsCubit.updateCriteria(eventLevel: value);
    }
  }

  List<Widget> _generateChoices(String groupValue, Iterable<Event> events) {
    final possibleValues = {EventsFilterCriteria.anyLevel};

    events.forEach((e) {
      final levels = e.level.split(',').map((e) => e.trim());
      possibleValues.addAll(levels);
    });
    return possibleValues
        .map((e) => RadioListTile<String>(
              title: Text(e),
              value: e,
              groupValue: groupValue,
              onChanged: _onValueChanged,
            ))
        .toList();
  }
}
