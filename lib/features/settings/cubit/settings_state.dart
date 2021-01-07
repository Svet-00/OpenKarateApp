import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:path_provider/path_provider.dart';

part 'settings_state.g.dart';

@JsonSerializable()
class SettingsState extends Equatable {
  final String fingerprint;
  SettingsState({
    @required this.fingerprint,
  }) : assert(fingerprint != null);

  factory SettingsState.fromJson(Map<String, dynamic> json) =>
      _$SettingsStateFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsStateToJson(this);

  Future<Directory> get downloadsDirectory => _getDownloadsDirectory();

  Future<Directory> _getDownloadsDirectory() async {
    if (Platform.isAndroid) {
      return await getApplicationSupportDirectory();
    }
    if (Platform.isIOS) {
      return await getApplicationDocumentsDirectory();
    }
    return await getDownloadsDirectory();
  }

  @override
  List<Object> get props => [fingerprint];

  @override
  bool get stringify => true;

  SettingsState copyWith({
    String fingerprint,
  }) {
    return SettingsState(
      fingerprint: fingerprint ?? this.fingerprint,
    );
  }
}
