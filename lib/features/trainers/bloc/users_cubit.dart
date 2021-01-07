import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../core/exceptions/server_exceptions.dart';
import '../../../core/utils/nullable.dart';
import '../../../domain/page_status.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../localizations/error_localizations.dart';
import 'users_state.dart';

export 'users_state.dart';

class UsersCubit extends HydratedCubit<UsersState> {
  final UserRepository userRepository;

  UsersCubit({
    @required this.userRepository,
  }) : super(const UsersState()) {
    update();
  }

  Future<void> update() async {
    try {
      final trainers = await userRepository.fetchTrainers();
      emit(UsersState(pageStatus: PageStatus.success, users: trainers));
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

  void dismissError() {
    emit(state.copyWith(errorMessage: Nullable.forceNull()));
  }

  @override
  UsersState fromJson(Map<String, dynamic> json) => UsersState.fromJson(json);

  @override
  Map<String, dynamic> toJson(UsersState state) => state.toJson();
}
