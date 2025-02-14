import 'package:multiversx_crypto/src/bip_44.dart';
import 'package:pinenacl/api.dart';
import 'package:pinenacl/ed25519.dart' as ed25519;
import 'package:convert/convert.dart' as convert;

/// The `SigningKey` class provides methods to generate and manage Ed25519 signing keys.
///
/// This class supports creating signing keys from a mnemonic, entropy, or generating new keys.
/// It also provides methods to sign data and retrieve the corresponding public key.
class SigningKey {
  /// Creates a `SigningKey` from a mnemonic phrase.
  ///
  /// The mnemonic is used to derive a seed, which is then used to create the signing key.
  ///
  /// - Parameter mnemonic: The mnemonic phrase.
  /// - Returns: A `Future` that completes with the `SigningKey`.
  static Future<SigningKey> fromMnemonic(final String mnemonic) async {
    final bip44 = Bip44.fromMnemonic(mnemonic);
    return SigningKey._(
      ed25519.SigningKey.fromSeed(
        Uint8List.fromList(
          await bip44.deriveKey(),
        ),
      ),
    );
  }

  /// Creates a `SigningKey` from entropy.
  ///
  /// The entropy is used to derive a seed, which is then used to create the signing key.
  ///
  /// - Parameter entropy: The entropy string.
  /// - Returns: A `Future` that completes with the `SigningKey`.
  static Future<SigningKey> fromEntropy(final String entropy) async {
    final bip44 = Bip44.fromEntropy(entropy);
    return SigningKey._(
      ed25519.SigningKey.fromSeed(
        Uint8List.fromList(
          await bip44.deriveKey(),
        ),
      ),
    );
  }

  /// Generates a new `SigningKey`.
  ///
  /// A new seed is generated and used to create the signing key.
  ///
  /// - Returns: A `Future` that completes with the `SigningKey`.
  static Future<SigningKey> generate() async {
    final bip44 = Bip44.generate();
    return SigningKey._(
      ed25519.SigningKey.fromSeed(
        Uint8List.fromList(
          await bip44.deriveKey(),
        ),
      ),
    );
  }

  final ed25519.SigningKey _signingKey;

  /// Private constructor for creating a `SigningKey` from an Ed25519 signing key.
  SigningKey._(this._signingKey);

  /// Creates a `SigningKey` from valid key bytes.
  ///
  /// - Parameter bytes: The key bytes.
  SigningKey.fromValidKey({required final Uint8List bytes})
      : _signingKey = ed25519.SigningKey.fromValidBytes(bytes);

  /// Creates a `SigningKey` from a provided seed.
  ///
  /// The seed must be a valid length for Ed25519 key generation.
  ///
  /// - Parameter seed: The seed bytes to use for key generation.
  SigningKey.fromSeed({required final Uint8List seed})
      : _signingKey = ed25519.SigningKey.fromSeed(seed);

  /// Gets the key bytes.
  ///
  /// - Returns: A list of integers representing the key bytes.
  List<int> get bytes => _signingKey.toList();

  /// Gets the corresponding public key.
  ///
  /// - Returns: The `PublicKey` associated with this signing key.
  PublicKey get publicKey => PublicKey(_signingKey.publicKey);

  /// Signs the given data.
  ///
  /// The data is signed using the Ed25519 signing key.
  ///
  /// - Parameter data: The data to sign.
  /// - Returns: A list of integers representing the signature.
  List<int> sign(final List<int> data) {
    final signedMessage = _signingKey.sign(Uint8List.fromList(data));
    return signedMessage.signature.toList();
  }
}

final _bech32Encoder = ed25519.Bech32Encoder(hrp: 'erd');
const pubkeyLength = 32;

class PublicKey {
  final List<int> bytes;

  const PublicKey(this.bytes)
      : assert(bytes.length == pubkeyLength,
            'bytes length must be equal to $pubkeyLength but it is ${bytes.length}');

  PublicKey.fromAddress(final PublicKey publicKey) : bytes = publicKey.bytes;

  PublicKey.fromBech32(final String bech32)
      : bytes = _bech32Encoder.decode(bech32);

  PublicKey.fromHex(final String hex) : bytes = convert.hex.decode(hex);

  PublicKey.zero() : bytes = List.generate(32, (_) => 0, growable: false);

  @override
  int get hashCode => bytes.hashCode;

  String get hex => convert.hex.encode(bytes);

  String get bech32 => _bech32Encoder.encode(bytes);

  @override
  bool operator ==(final Object other) =>
      other is PublicKey && bytes == other.bytes;
}
