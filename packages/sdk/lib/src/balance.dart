import 'dart:math' as math;

/// The number of decimal places used for EGLD denomination.
const denomination = 18;

/// Represents one EGLD in its smallest unit.
final oneEGLD = BigInt.from(1000000000000000000);

/// Represents a balance of EGLD cryptocurrency.
///
/// This class provides methods for creating, manipulating, and formatting EGLD balances.
class Balance {
  /// The value of the balance in attoEGLD (smallest unit).
  final BigInt value;

  /// Creates a new [Balance] instance with the given [value].
  ///
  /// The [value] must be non-negative.
  Balance(this.value)
      : assert(value >= BigInt.zero, 'balance cannot be negative');

  /// Creates a new [Balance] instance with a zero value.
  Balance.zero() : value = BigInt.from(0);

  /// Creates a new [Balance] instance from a string representation.
  ///
  /// The [value] should be a valid string representation of a BigInt.
  factory Balance.fromString(String value) {
    return Balance(BigInt.parse(value));
  }

  /// Creates a new [Balance] instance from a numeric value.
  ///
  /// The [value] will be converted to a BigInt.
  factory Balance.fromNum(num value) {
    return Balance(BigInt.from(value));
  }

  /// Creates a new [Balance] instance from an EGLD value.
  ///
  /// The [value] can be a decimal number representing EGLD.
  /// This method handles the conversion from EGLD to attoEGLD.
  factory Balance.fromEgld(num value) {
    var v = value;
    var count = 0;
    while (v.truncate() != v) {
      v = v * 10;
      count++;
    }
    final bigGold = BigInt.from(v);
    final bigUnits = bigGold * (oneEGLD ~/ BigInt.from(math.pow(10, count)));
    return Balance(bigUnits);
  }

  /// Returns the balance as a denominated string.
  ///
  /// The returned string represents the balance in EGLD format,
  /// with 18 decimal places.
  String get toDenominated {
    final padded = value.toString().padLeft(denomination, '0');
    final decimals = padded.substring(padded.length - denomination);
    final integer =
        padded.substring(0, padded.length - denomination).padLeft(1, '0');
    return '$integer.$decimals';
  }

  /// Returns a string representation of the [Balance] instance.
  @override
  String toString() => 'Balance{ $toDenominated }';
}
