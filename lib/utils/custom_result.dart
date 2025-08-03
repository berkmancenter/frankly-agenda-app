sealed class CustomResult<T> {
  const CustomResult();

  const factory CustomResult.ok(T value) = Ok._;

  const factory CustomResult.error(Exception error, [String? displayError]) = Error._;

  get value => null;
}

/// Subclass of result - Ok
final class Ok<T> extends CustomResult<T> {
  const Ok._(this.value);

  @override
  final T value;

  @override
  String toString() => 'Result<$T>.ok($value)';
}

/// Subclass of result - Error
final class Error<T> extends CustomResult<T> {
  const Error._(this.error, [this.displayError]);

  final Exception error;

  final String? displayError;

  @override
  String toString() => 'Result<$T>.error($error)';
}
