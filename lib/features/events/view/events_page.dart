import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/injection_container.dart';
import '../../../domain/repositories/event_repository.dart';
import '../../../presentation/widgets/app_scaffold.dart';
import '../../authorization/cubit/authorization_cubit.dart';
import '../bloc/events_cubit.dart';
import 'events_calendar_view.dart';
import 'events_filter_page.dart';
import 'events_list_view.dart';

class EventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<EventsCubit>(
      create: (context) => EventsCubit(
        sl<EventRepository>(),
        BlocProvider.of<AuthorizationCubit>(context),
      ),
      child: _EventsPageContent(),
    );
  }
}

class _EventsPageContent extends StatelessWidget {
  const _EventsPageContent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text('События'),
        actions: [
          BlocBuilder<EventsCubit, EventsState>(
            builder: (context, state) => IconButton(
              icon: Icon(state.calendarView ? Icons.list : Icons.event),
              onPressed: () {
                final eventsCubit = context.read<EventsCubit>();
                eventsCubit.toggleCalendarView();
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<EventsCubit, EventsState>(
        builder: (context, state) =>
            state.calendarView ? EventsCalendarView() : EventsListView(),
      ),
      floatingActionButton: OpenContainer(
        openColor: Theme.of(context).colorScheme.background,
        closedColor: Theme.of(context).colorScheme.secondary,
        transitionDuration: Duration(milliseconds: 500),
        transitionType: ContainerTransitionType.fade,
        closedElevation: 2,
        tappable: false,
        closedShape: CircleBorder(),
        closedBuilder: (ctx, action) {
          return FloatingActionButton(
            child: const Icon(Icons.filter_alt),
            onPressed: action,
          );
        },
        openBuilder: (ctx, action) {
          return BlocProvider.value(
            value: BlocProvider.of<EventsCubit>(context),
            child: EventsFilterPage(
              closeCallback: action,
            ),
          );
        },
      ),
    );
  }
}
