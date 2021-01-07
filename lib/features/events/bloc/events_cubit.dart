import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logger/logger.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/exceptions/exceptions.dart';
import '../../../core/injection_container.dart';
import '../../../core/utils/datetime_x.dart';
import '../../../core/utils/nullable.dart';
import '../../../domain/entities/event.dart';
import '../../../domain/repositories/event_repository.dart';
import '../../authorization/cubit/authorization_cubit.dart';
import '../../localizations/error_localizations.dart';
import 'events_holder.dart';
import 'events_state.dart';

export 'events_state.dart';

class EventsCubit extends HydratedCubit<EventsState> {
  final EventRepository eventRepository;
  final AuthorizationCubit authorizationCubit;
  final logger = sl<Logger>();

  EventsCubit(this.eventRepository, this.authorizationCubit)
      : super(EventsState(
          events: EventsHolder(const []),
          filtered: EventsHolder(const []),
        )) {
    update();
  }

  Future<void> update() async {
    try {
      final events = await eventRepository.fetchEvents();
      emit(state.copyWith(
        pageStatus: state.pageStatus.isFiltered
            ? EventsStatus.filtered
            : EventsStatus.success,
        events: EventsHolder(events),
      ));
    } on ServerException catch (e, st) {
      emit(state.copyWith(
        errorMessage: Nullable.notNull(
          ErrorLocalizations.checkNetworkConnection(),
        ),
      ));
      logger.w('Events Cubit', e, st);
    } on Exception catch (e, st) {
      logger.e('EventsCubit', e, st);
    }
  }

  Future<void> participate(Event event) async {
    if (authorizationCubit.state.status.isGuest) return;
    final user = authorizationCubit.state.user;
    if (user.eventIds.contains(event.id)) {
      sl<Logger>().wtf(
        'Logged in user is already participating in ${event.title}',
      );
    } else {
      final newList = List<String>.from(user.eventIds);
      newList.add(event.id);
      await authorizationCubit.updateUserProfile(
        user.copyWith(
          eventIds: newList,
        ),
      );
    }
  }

  Future<void> stopParticipating(Event event) async {
    if (authorizationCubit.state.status.isGuest) return;
    final user = authorizationCubit.state.user;

    if (user.eventIds.contains(event.id) == false) {
      sl<Logger>().wtf(
        'Logged in user is not participating in ${event.title}',
      );
    } else {
      final newList = List<String>.from(user.eventIds);
      newList.remove(event.id);
      await authorizationCubit.updateUserProfile(
        user.copyWith(
          eventIds: newList,
        ),
      );
    }
  }

  Future<void> filter() async {
    final c = state.criteria;
    final filtered = List<Event>.from(
      state.events.set,
    );

    filtered.removeWhere(
      (e) {
        var result = false;
        if (e.endDate.toDate().isAfter(c.endDate) ||
            e.startDate.toDate().isBefore(c.startDate)) {
          return true;
        }
        if (c.type != EventsFilterCriteria.anyType) {
          final matches =
              e.type.split(',').map((e) => e.trim()).where((e) => e == c.type);
          result = matches.isEmpty;
          if (result) return result;
        }
        if (c.level != EventsFilterCriteria.anyLevel) {
          final matches = e.level
              .split(',')
              .map((e) => e.trim())
              .where((e) => e == c.level);
          result = matches.isEmpty;
          if (result) return result;
        }
        return result;
      },
    );
    emit(state.copyWith(
      pageStatus: EventsStatus.filtered,
      filtered: EventsHolder(filtered),
      criteria: c,
      calendarView: false,
    ));
  }

  void resetFilter() {
    final pageStatus =
        state.pageStatus.isFiltered ? EventsStatus.success : state.pageStatus;
    emit(
      state.copyWith(
        pageStatus: pageStatus,
        criteria: EventsFilterCriteria(),
        filtered: EventsHolder(const []),
      ),
    );
  }

  void dismissError() {
    emit(state.copyWith(errorMessage: Nullable.forceNull()));
  }

  void updateCriteria({
    String eventLevel,
    String eventType,
    DateTime startDate,
    DateTime endDate,
  }) {
    final c = state.criteria ?? EventsFilterCriteria();
    emit(
      state.copyWith(
        criteria: c.copyWith(
          level: eventLevel,
          type: eventType,
          startDate: startDate,
          endDate: endDate,
        ),
      ),
    );
  }

  void toggleCalendarView() {
    if (!state.calendarView) resetFilter();
    emit(state.copyWith(calendarView: !state.calendarView));
  }

  void selectDate(DateTime day) {
    assert(day != null);
    final date = day.toDate();

    emit(state.copyWith(selectedDate: Nullable.notNull(date)));
  }

  void maybeResetSelectedDate([CalendarFormat format]) {
    if (format == null || format == state.calendarFormat) {
      emit(state.copyWith(selectedDate: Nullable.forceNull()));
    } else {
      emit(state.copyWith(calendarFormat: format));
    }
  }

  @override
  EventsState fromJson(Map<String, dynamic> json) => EventsState.fromJson(json);

  @override
  Map<String, dynamic> toJson(EventsState state) => state.toJson();
}
