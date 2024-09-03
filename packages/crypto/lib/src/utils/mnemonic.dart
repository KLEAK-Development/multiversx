import 'package:bip39/bip39.dart';

/// A type alias for a mnemonic phrase represented as a [String].
///
/// A mnemonic is typically a sequence of words used to generate
/// cryptographic keys or seed phrases in cryptocurrency wallets.
typedef Mnemonic = String;

/// Extension on [String] to provide mnemonic validation functionality.
extension ValidMnemonic on String {
  /// Checks if the current string is a valid mnemonic phrase.
  ///
  /// Returns `true` if the string is a valid mnemonic, `false` otherwise.
  /// This method uses the `validateMnemonic` function from the `bip39` package.
  ///
  /// Example:
  /// ```dart
  /// final mnemonic = "word1 word2 word3 ...";
  /// if (mnemonic.isValid()) {
  ///   print("Valid mnemonic");
  /// } else {
  ///   print("Invalid mnemonic");
  /// }
  /// ```
  bool isValid() => validateMnemonic(this);
}
