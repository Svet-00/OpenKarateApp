extension DateTimeX on DateTime {
  /// Returns new [DateTime] in UTC timezone with everything
  /// except date part equals to zero
  DateTime toDate() {
    return DateTime.utc(year, month, day);
  }
}
