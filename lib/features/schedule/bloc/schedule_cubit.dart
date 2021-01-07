import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../core/exceptions/exceptions.dart';
import '../../../core/utils/nullable.dart';
import '../../../domain/page_status.dart';
import '../../../domain/repositories/gym_repository.dart';
import '../../../domain/repositories/schedule_repository.dart';
import '../../localizations/error_localizations.dart';
import 'schedule_state.dart';

export 'schedule_state.dart';

class ScheduleCubit extends HydratedCubit<ScheduleState> {
  final GymRepository gymRepository;
  final ScheduleRepository scheduleRepository;

  ScheduleCubit({
    @required this.gymRepository,
    @required this.scheduleRepository,
  }) : super(const ScheduleState()) {
    update();
  }

  Future<void> load() async {
    await _load(false);
  }

  Future<void> update() async {
    await _load(true);
  }

  Future<void> _load(bool update) async {
    try {
      final gyms = await gymRepository.fetchAll();
      final schedules = await scheduleRepository.fetchAll();

      emit(
        ScheduleState(
          pageStatus: PageStatus.success,
          gyms: gyms,
          schedules: schedules,
        ),
      );
    } on ServerException {
      emit(
        state.copyWith(
          errorMessage: Nullable.notNull(
            ErrorLocalizations.checkNetworkConnection(),
          ),
        ),
      );
    }
  }

  @override
  ScheduleState fromJson(Map<String, dynamic> json) =>
      ScheduleState.fromJson(json);

  @override
  Map<String, dynamic> toJson(ScheduleState state) => state.toJson();
}
