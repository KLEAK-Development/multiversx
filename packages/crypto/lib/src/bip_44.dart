import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:bip39/bip39.dart';
import 'package:multiversx_crypto/src/utils/mnemonic.dart';

const _defaultMnemonicStrength = 256;
const bip44DerivationPrefix = "m/44'/508'/0'/0'";

/// A class that provides functionality for BIP-44 hierarchical deterministic wallets.
///
/// BIP-44 is a standard for deterministic wallets that allows for the generation
/// of multiple key pairs from a single seed phrase (mnemonic). This class supports
/// generating a new mnemonic, deriving keys from a mnemonic, and converting between
/// entropy and mnemonic.
///
/// Example usage:
/// ```dart
/// // Generate a new BIP-44 wallet
/// final wallet = Bip44.generate();
///
/// // Derive a key for a specific address index
/// final key = await wallet.deriveKey(addressIndex: 0);
///
/// // Get the mnemonic for the wallet
/// final mnemonic = wallet.mnemonic;
/// ```
///
/// See also:
/// - [BIP-44 specification](https://github.com/bitcoin/bips/blob/master/bip-0044.mediawiki)
class Bip44 {
  final String entropy;

  const Bip44._(this.entropy);

  /// Creates a [Bip44] instance from the given [entropy].
  ///
  /// The [entropy] is converted to a mnemonic, which is validated.
  ///
  /// Throws an [AssertionError] if the mnemonic is not valid.
  factory Bip44.fromEntropy(String entropy) {
    final mnemonic = entropyToMnemonic(entropy);
    assert(mnemonic.isValid(), 'mnemonic is not valid');
    return Bip44._(entropy);
  }

  /// Creates a [Bip44] instance from the given [mnemonic].
  ///
  /// The [mnemonic] is validated and converted to entropy.
  ///
  /// Throws an [AssertionError] if the mnemonic is not valid.
  factory Bip44.fromMnemonic(final String mnemonic) {
    assert(mnemonic.isValid(), 'mnemonic is not valid');
    return Bip44._(mnemonicToEntropy(mnemonic.trim()));
  }

  /// Generates a new [Bip44] instance with a random mnemonic.
  ///
  /// The [strength] parameter determines the strength of the mnemonic.
  /// The default strength is 256 bits.
  factory Bip44.generate({final int strength = _defaultMnemonicStrength}) {
    final mnemonic = generateMnemonic(strength: strength);
    return Bip44.fromMnemonic(mnemonic);
  }

  /// Derives a key for the given [addressIndex] and [password].
  ///
  /// The key is derived using the BIP-44 derivation path and the mnemonic's seed.
  ///
  /// Returns a [Future] that completes with the derived key as a list of bytes.
  Future<List<int>> deriveKey({
    final int addressIndex = 0,
    final String password = '',
  }) async {
    final seed =
        mnemonicToSeed(entropyToMnemonic(entropy), passphrase: password);
    final data = await ED25519_HD_KEY.derivePath(
        "$bip44DerivationPrefix/$addressIndex'", seed);
    return data.key;
  }

  /// Returns the mnemonic associated with this [Bip44] instance.
  ///
  /// The mnemonic is derived from the entropy.
  String get mnemonic => entropyToMnemonic(entropy);
}
