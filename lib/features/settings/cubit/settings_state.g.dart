// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsState _$SettingsStateFromJson(Map<String, dynamic> json) {
  return $checkedNew('SettingsState', json, () {
    final val = SettingsState(
      fingerprint: $checkedConvert(json, 'fingerprint', (v) => v as String),
    );
    return val;
  });
}

Map<String, dynamic> _$SettingsStateToJson(SettingsState instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fingerprint', instance.fingerprint);
  return val;
}
