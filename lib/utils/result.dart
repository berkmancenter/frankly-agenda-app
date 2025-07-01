sealed class Result<T> {
  const Result();

  const factory Result.ok(T value) = Ok._;

  const factory Result.error(Exception error, [String? displayError]) = Error._;
}

/// Subclass of result - Ok
final class Ok<T> extends Result<T> {
  const Ok._(this.value);

  final T value;

  @override
  String toString() => 'Result<$T>.ok($value)';
}

/// Subclass of result - Error
final class Error<T> extends Result<T> {
  const Error._(this.error, [this.displayError]);

  final Exception error;

  final String? displayError;

  @override
  String toString() => 'Result<$T>.error($error)';
}
