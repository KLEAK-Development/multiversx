/// Represents a nonce (number used once) in cryptographic operations.
///
/// A nonce is typically used to ensure uniqueness in cryptographic
/// communications and to prevent replay attacks.
class Nonce {
  /// The integer value of the nonce.
  final int value;

  /// Creates a new [Nonce] with the specified [value].
  ///
  /// Throws an [AssertionError] if the [value] is negative.
  const Nonce(this.value) : assert(value >= 0, 'nonce cannot be negative');

  /// Creates a new [Nonce] with a value of zero.
  const Nonce.zero() : value = 0;

  /// Returns a new [Nonce] with its value incremented by 1.
  Nonce increment() => Nonce(value + 1);

  @override
  String toString() => 'Nonce{ $value }';
}
