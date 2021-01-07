class UserLevel {
  final int _numericValue;
  int get numericValue => _numericValue;

  static const notASportsmanValue = 0;
  static const maxLevel = 21;

  const UserLevel(int level)
      : _numericValue = level,
        assert(level <= maxLevel);

  /// Not a sportsman
  const UserLevel.na() : _numericValue = notASportsmanValue;

  UserLevel.fromString(String levelString)
      : _numericValue = _parseStringValue(levelString);

  bool get isSportsman => numericValue != notASportsmanValue;
  bool get isKyu => isSportsman && numericValue < 12;
  bool get isDan => isSportsman && !isKyu;

  @override
  String toString() {
    // should be 2 words, fromString depends on it
    if (!isSportsman) return 'Не спортсмен';
    if (isKyu) {
      return '$numericValue Кю';
    }
    return '${numericValue - 11} Дан';
  }

  @override
  bool operator ==(other) {
    return identical(this, other) ||
        (other is UserLevel && numericValue == other.numericValue) ||
        (other is int) && numericValue == other;
  }
}

int _parseStringValue(String levelString) {
  final exp = RegExp(r'^(\d{1,2}|Не) (Кю|Дан|спортсмен)$');
  if (!exp.hasMatch(levelString)) {
    throw FormatException('Incorrect user level string', levelString);
  }
  final pieces = levelString.split(' ');
  final givenNumber = int.parse(pieces.first);
  final result = pieces.last == 'Дан' ? givenNumber + 11 : givenNumber;

  assert(result <= UserLevel.maxLevel);
  return result;
}
