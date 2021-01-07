import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../core/utils/uuid.dart';
import 'settings_state.dart';

export './settings_state.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit()
      : super(
          SettingsState(
            fingerprint: uuid.v4(),
          ),
        );

  @override
  SettingsState fromJson(Map<String, dynamic> json) =>
      SettingsState.fromJson(json);

  @override
  Map<String, dynamic> toJson(SettingsState state) => state.toJson();
}
