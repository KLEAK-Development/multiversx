import 'package:convert/convert.dart' as convert;

/// Represents a cryptographic signature.
///
/// This class provides a way to store and manipulate signatures
/// in hexadecimal format.
class Signature {
  /// The hexadecimal representation of the signature.
  final String hex;

  /// Creates a [Signature] with the given hexadecimal string.
  ///
  /// [hex] should be a valid hexadecimal string representing the signature.
  const Signature(this.hex);

  /// Creates an empty [Signature].
  ///
  /// The [hex] value will be an empty string.
  const Signature.empty() : hex = '';

  /// Creates a [Signature] from a list of bytes.
  ///
  /// [bytes] should be a list of integers representing the signature.
  /// The bytes are converted to a hexadecimal string.
  factory Signature.fromBytes(List<int> bytes) =>
      Signature(convert.hex.encode(bytes));

  /// Returns the bytes representation of this signature.
  ///
  /// Decodes the hexadecimal string into a list of bytes.
  /// Returns an empty list if the signature is empty.
  List<int> get bytes => convert.hex.decode(hex);
}
