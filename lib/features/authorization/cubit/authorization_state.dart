import 'package:json_annotation/json_annotation.dart';

import '../../../core/exceptions/server_exceptions.dart';
import '../../../core/models/registration_info.dart';
import '../../../core/utils/nullable.dart';
import '../../../domain/entities/user.dart';

part 'authorization_state.g.dart';

enum AuthorizationStatus { guest, authorized }
enum AuthorizationPageStatus { showingForm, loading, success }

extension AuthorizationStatusX on AuthorizationStatus {
  bool get isGuest => this == AuthorizationStatus.guest;
  bool get isAuthorized => this == AuthorizationStatus.authorized;
}

extension AuthorizationPageStatusX on AuthorizationPageStatus {
  bool get isShowingForm => this == AuthorizationPageStatus.showingForm;
  bool get isLoading => this == AuthorizationPageStatus.loading;
  bool get isSuccess => this == AuthorizationPageStatus.success;
}

@JsonSerializable()
class AuthorizationState {
  @JsonKey(unknownEnumValue: AuthorizationPageStatus.showingForm)
  final AuthorizationPageStatus pageStatus;
  final RegistrationInfo registrationInfo;
  final User user;
  final ServerAuthorizationException authError;
  final String generalError;

  const AuthorizationState({
    this.pageStatus = AuthorizationPageStatus.showingForm,
    this.registrationInfo = const RegistrationInfo(),
    this.user,
    this.generalError,
    this.authError,
  })  : assert(pageStatus != null),
        assert(registrationInfo != null);

  AuthorizationStatus get status {
    return user == null
        ? AuthorizationStatus.guest
        : AuthorizationStatus.authorized;
  }

  factory AuthorizationState.fromJson(Map<String, dynamic> json) =>
      _$AuthorizationStateFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorizationStateToJson(this);

  @override
  String toString() {
    return 'AuthorizationState(status: $status, pageStatus: $pageStatus, registrationInfo: $registrationInfo, user: $user, authError: $authError, generalError: $generalError)';
  }

  AuthorizationState copyWith({
    AuthorizationPageStatus pageStatus,
    RegistrationInfo registrationInfo,
    Nullable<User> user,
    Nullable<ServerAuthorizationException> authError,
    Nullable<String> generalError,
  }) {
    return AuthorizationState(
      pageStatus: pageStatus ?? this.pageStatus,
      registrationInfo: registrationInfo ?? this.registrationInfo,
      user: user == null ? this.user : user.value,
      authError: authError == null ? this.authError : authError.value,
      generalError:
          generalError == null ? this.generalError : generalError.value,
    );
  }
}
