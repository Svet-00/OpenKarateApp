import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:openkarateapp/domain/entities/gym.dart';

import '../../../core/exceptions/server_exceptions.dart';
import '../../../core/utils/nullable.dart';
import '../../../domain/page_status.dart';
import '../../../domain/repositories/gym_repository.dart';
import '../../localizations/error_localizations.dart';
import 'gyms_state.dart';

export 'gyms_state.dart';

class GymsCubit extends HydratedCubit<GymsState> {
  final GymRepository gymRepository;

  GymsCubit({@required this.gymRepository}) : super(const GymsState()) {
    update();
  }

  Future<void> update() async {
    try {
      final gyms = await gymRepository.fetchAll();
      emit(GymsState(pageStatus: PageStatus.success, gyms: gyms));
    } on ServerException {
      emit(
        state.copyWith(
          errorMessage: Nullable(
            ErrorLocalizations.checkNetworkConnection(),
          ),
        ),
      );
    }
  }

  Future<void> toggleFavorite(Gym gym) async {
    try {
      final index = state.gyms.indexOf(gym);
      if (index == -1) {
        throw StateError(
          'tried toggle favorite of gym which does not exist in state',
        );
      }

      if (gym.isFavorite) {
        await gymRepository.removeFromFavorites(gym.id);
      } else {
        await gymRepository.addToFavorites(gym.id);
      }

      final newList = List.of(state.gyms);
      newList[index] = gym.copyWith(isFavorite: !gym.isFavorite);
      emit(state.copyWith(gyms: newList));
    } on ServerException catch (e) {
      return;
    }
  }

  void dismissError() {
    emit(state.copyWith(errorMessage: Nullable.forceNull()));
  }

  @override
  GymsState fromJson(Map<String, dynamic> json) => GymsState.fromJson(json);

  @override
  Map<String, dynamic> toJson(GymsState state) => state.toJson();
}
