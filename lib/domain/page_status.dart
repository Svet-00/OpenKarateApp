enum PageStatus { initial, loading, success }

extension PageStatusX on PageStatus {
  bool get isInitial => this == PageStatus.initial;
  bool get isSuccess => this == PageStatus.success;
}
