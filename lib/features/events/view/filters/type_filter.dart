import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/event.dart';

import '../../../../presentation/widgets/app_scaffold.dart';
import '../../../../presentation/widgets/styled_raised_button.dart';
import '../../bloc/events_cubit.dart';

class EventTypeFilterPage extends StatelessWidget {
  final String title;
  final EventsCubit eventsCubit;
  const EventTypeFilterPage({
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
                children: _generateChoices(
                  state.events.set,
                  state.criteria?.type,
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

  List<Widget> _generateChoices(Iterable<Event> events, String groupValue) {
    final possibleValues = {EventsFilterCriteria.anyType};
    events.forEach((e) {
      final types = e.type.split(',').map((e) => e.trim());
      possibleValues.addAll(types);
    });
    return possibleValues
        .map<Widget>(
          (v) => RadioListTile<String>(
            title: Text(v),
            value: v,
            groupValue: groupValue,
            onChanged: _onValueChanged,
          ),
        )
        .toList();
  }

  void _onValueChanged(String value) {
    {
      eventsCubit.updateCriteria(eventType: value);
    }
  }
}
