/// Wrapper for copyWith functions that provides
/// the ability to pass null as field target value
class Nullable<T> {
  final T _value;

  /// Create wrapper from nullable value
  Nullable(T value) : _value = value;

  /// Creates wrapper from non-nullable value
  Nullable.notNull(T value)
      : assert(value != null),
        _value = value;

  /// Creates wrapper instance with null value
  Nullable.forceNull() : _value = null;

  T get value => _value;
}
