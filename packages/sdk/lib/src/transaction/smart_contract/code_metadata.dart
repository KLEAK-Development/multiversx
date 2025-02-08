/// A class representing code metadata for smart contracts.
/// This class manages contract properties such as upgradeability, readability, and payment capabilities.
class CodeMetadata {
  /// Indicates if the contract can be upgraded
  final bool upgradeable;

  /// Indicates if the contract is readable
  final bool readable;

  /// Indicates if the contract can receive payments
  final bool payable;

  /// Creates a CodeMetadata instance.
  ///
  /// By default:
  /// - [upgradeable] is true
  /// - [readable] is false
  /// - [payable] is false
  const CodeMetadata({
    this.upgradeable = true,
    this.readable = false,
    this.payable = false,
  });

  /// Returns a list of two bytes representing the metadata flags.
  ///
  /// The first byte (byteZero) contains upgradeable and readable flags.
  /// The second byte (byteOne) contains the payable flag.
  List<int> get bytes {
    var byteZero = 0;
    var byteOne = 0;

    if (upgradeable) {
      byteZero |= ByteZero.upgradeable.value;
    }
    if (readable) {
      byteZero |= ByteZero.readable.value;
    }
    if (payable) {
      byteOne |= ByteOne.payable.value;
    }

    return [byteZero, byteOne];
  }
}

/// A class representing the first byte of code metadata.
/// This byte contains flags for upgradeability and readability features.
class ByteZero {
  /// Flag indicating if the contract is upgradeable (value: 1)
  static const upgradeable = ByteZero._(1);

  /// Reserved flag - currently unused (value: 2)
  static const reserved2 = ByteZero._(2);

  /// Flag indicating if the contract is readable (value: 4)
  static const readable = ByteZero._(4);

  /// The numeric value of the flag
  final int value;

  /// Private constructor that takes the flag value
  const ByteZero._(this.value);
}

/// A class representing the second byte of code metadata.
/// This byte contains flags for payable features and reserved values.
class ByteOne {
  /// Reserved flag - currently unused (value: 1)
  static const reserved1 = ByteZero._(1);

  /// Flag indicating if the contract is payable (value: 2)
  static const payable = ByteZero._(2);

  /// The numeric value of the flag
  final int value;

  /// Private constructor that takes the flag value
  const ByteOne._(this.value);
}
