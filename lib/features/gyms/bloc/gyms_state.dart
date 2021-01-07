import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../core/utils/nullable.dart';
import '../../../domain/entities/gym.dart';
import '../../../domain/page_status.dart';

part 'gyms_state.g.dart';

@JsonSerializable()
class GymsState extends Equatable {
  @JsonKey(unknownEnumValue: PageStatus.initial)
  final PageStatus pageStatus;
  final List<Gym> gyms;
  final String errorMessage;
  const GymsState({
    this.pageStatus = PageStatus.initial,
    this.gyms = const [],
    this.errorMessage,
  })  : assert(pageStatus != null),
        assert(gyms != null);

  factory GymsState.fromJson(Map<String, dynamic> json) =>
      _$GymsStateFromJson(json);
  Map<String, dynamic> toJson() => _$GymsStateToJson(this);

  GymsState copyWith({
    PageStatus pageStatus,
    List<Gym> gyms,
    Nullable<String> errorMessage,
  }) {
    return GymsState(
      pageStatus: pageStatus ?? this.pageStatus,
      gyms: gyms ?? this.gyms,
      errorMessage:
          errorMessage == null ? this.errorMessage : errorMessage.value,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [pageStatus, gyms, errorMessage];
}
